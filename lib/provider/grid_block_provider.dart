import 'dart:async';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tetris_flutter/provider/global.dart';
import 'package:tetris_flutter/provider/button_function.dart';
import 'package:tetris_flutter/provider/blank_boxes_provider.dart';
import 'package:tetris_flutter/user_interface/blocks.dart';
import 'package:tetris_flutter/user_interface/main_screen.dart';
import 'package:tetris_flutter/user_interface/main_screen.dart' as main_screen;

part 'grid_block_provider.g.dart';

typedef LiGrid = List<GridValue>;

///class initializer - what should be inside the list of blocks, LiGrid something like this//////////////////////////////////
class GridValue {
  final bool isPlayer;
  final bool isBlock;
  final Widget container;
  const GridValue(
      {required this.container, required this.isPlayer, required this.isBlock});
}

///generated notifier provider by riverpod////////////////////////////////
@riverpod
class Grid extends _$Grid {
  static final blankBox = GridValue(
      isPlayer: false,
      isBlock: false,
      container: Container(color: BlockPicker(colorIndex: 0).getColorBlock));

  final int initialBlock = 30;
  LiGrid initialBlockLayout() {
    return [for (int i = 0; i < 220; i++) blankBox];
  }

  @override
  LiGrid build() {
    return initialBlockLayout();
  }

  ///static and data encoders

  static int blocksGenerated = 0;

  static int downTimerSpeed = 2000;

  static late int currentBlock;

  static List<int> findPlayer(LiGrid state) => [
        for (var i = 0; i < state.length; i++)
          if (state[i].isPlayer) i
      ];

  static Widget findContainerColor(LiGrid currentState) {
    return currentState.firstWhere((gridValue) => gridValue.isPlayer).container;
  }

// --------------automatic and repeating code-----------------

  void startGame() async {
    ref.read(blockQueueProvider.notifier).firstGenerateQueue();
    generateBlock();
    updateGrid();
    await Future.doWhile(() async {
      await downTimer(blocksGenerated);
      return checkIfInGame();
    });
  }

  bool checkIfInGame() {
    if (!inGame) {
      blocksGenerated = 0;
      downTimerSpeed = 2000;
      state = initialBlockLayout();
      updateGrid();
      ref.read(blockQueueProvider.notifier).emptyQueue();
      ref.read(reserveBlockProvider.notifier).restartBlock();
      return false;
    }
    return true;
  }

  Future downTimer(int currentBlock) async {
    int countdown = 3;
    while (currentBlock == blocksGenerated) {
      await Future.delayed(Duration(milliseconds: downTimerSpeed), () async {
        if (!checkIfInGame() || currentBlock != blocksGenerated) {
          return state;
        } else if (isValidPlace(state, findPlayer(state), 'Down')) {
          moveDown(state, findPlayer(state)).then((value) => state = value);
        } else {
          bool isBottom = true;
          while (isBottom) {
            await Future.delayed(const Duration(seconds: 1));
            if (!checkIfInGame()) {
              return state;
            }
            if (isValidPlace(state, findPlayer(state), 'Down')) {
              moveDown(state, findPlayer(state)).then((value) => state = value);
              countdown = 3;
              isBottom = false;
            } else if (countdown != 0) {
              countdown--;
            } else {
              isBottom = false;
              await placeBlock(state, findPlayer(state)).then((value) {
                ref.read(blockQueueProvider.notifier).removeFirstAddAnother();
                return state = value;
              });
              checkRowFull();
              generateBlock();
            }
          }
        }
      });
      updateGrid();
    }
  }

  static LiGrid highLightDrop(LiGrid currentState,
      {bool fromButton = false, List<int>? providedPlayer}) {
    // logic for highlighting drop zone
    List<int> player = providedPlayer ?? findPlayer(currentState);
    currentState.asMap().forEach((index, element) {
      if (element.isBlock == false && element.isPlayer == false) {
        currentState[index] = blankBox;
      }
    });
    while (isValidPlace(currentState, player, 'Down')) {
      for (int i = 0; i < 4; i++) {
        player[i] += 10;
      }
    }
    for (int p in player) {
      if (!currentState[p].isBlock && !currentState[p].isPlayer) {
        currentState[p] = GridValue(
          isPlayer: fromButton ? true : false,
          isBlock: fromButton ? true : false,
          container: Container(
              color: fromButton
                  ? BlockPicker(colorIndex: currentBlock).getColorBlock
                  : BlockPicker(colorIndex: currentBlock)
                      .getHighLightedColorBlock),
        );
      }
    }
    return currentState;
  }

  /// event codes - whenver the program or the user do something, such as:
  /// validity of blocks, updating, generate, finalizing blocks

  void updateGrid() {
    if (state.any((element) => element.isPlayer)) {
      highLightDrop(state);
    }
    state = [
      ...state,
      GridValue(
          isPlayer: false,
          isBlock: false,
          container: Container(color: BlockPicker(colorIndex: 0).getColorBlock))
    ];
    state.removeLast();
  }

  static bool isValidPlace(
    LiGrid currentState,
    List<int> currentPlayer,
    String movement,
  ) {
    bool? result;
    List<int> left() => [for (int i = 20; i <= 200; i += 10) i];

    List<int> right() => [for (int i = 29; i <= 209; i += 10) i];

    List<int> bottom() => [for (int i = 200; i <= 219; i++) i];

    if (movement == "Down") {
      for (int i in currentPlayer) {
        if (bottom().contains(i) ||
            (currentState[i + 10].isBlock && !currentState[i + 10].isPlayer)) {
          result = false;
        }
      }
    }
    if (movement == "Left") {
      for (int i in currentPlayer) {
        if (left().contains(i) ||
            (currentState[i - 1].isBlock && !currentState[i - 1].isPlayer)) {
          result = false;
        }
      }
    }

    if (movement == "Right") {
      for (int i in currentPlayer) {
        if (right().contains(i) ||
            (currentState[i + 1].isBlock && !currentState[i + 1].isPlayer)) {
          result = false;
        }
      }
    }

    if (movement == "Rotate" || movement == "Switch") {
      int i = 0;
      int r = 0;
      if (left().any((element) => currentPlayer.contains(element))) i++;
      if (right().any((element) => currentPlayer.contains(element))) r++;
      if (i != 0 && r != 0) return false;
    }

    return result ?? true;
  }

  static Future<LiGrid> placeBlock(
      LiGrid currentState, List<int> currentPlayer) async {
    Widget containers = findContainerColor(currentState);
    for (int i in currentPlayer) {
      currentState[i] =
          GridValue(isPlayer: false, isBlock: true, container: containers);
    }
    return currentState;
  }

  Future generateBlock() async {
    int pick = ref.watch(blockQueueProvider.notifier).state.first;
    Map<int, GridValue> holder = {};
    bool adjustment = true;
    currentBlock = pick;
    for (var i in BlockPicker(colorIndex: currentBlock).pickBlock().entries) {
      holder[i.key] = GridValue(
          isPlayer: true, isBlock: true, container: Container(color: i.value));
    }
    do {
      int any = 0;
      for (var i in holder.entries) {
        if (state[i.key].isBlock && !state[i.key].isPlayer) {
          any++;
        }
      }
      if (any == 0) {
        adjustment = false;
      } else {
        List<int> holderAdjustment = [];
        GridValue value = GridValue(
          isPlayer: true, isBlock: true, container: Container());
        for(var i in holder.entries){
          holderAdjustment.add(i.key-10);
          value = i.value;
        }
        holder.clear();
        for (int i in holderAdjustment) {
          holder[i] = value;
        }
      }
    } while (adjustment);
    for(var i in holder.entries){
      state[i.key] = i.value;
    }

    blocksGenerated++;
  }

  void checkRowFull({int multiplier = 0}) {
    for (int i = 209; i > 20; i -= 10) {
      int holder = 0;
      for (int row = i; row > i - 10; row--) {
        if (state[row].isBlock) {
          holder++;
        }
        if (holder == 10) {
          clearRow(i);
          checkRowFull(multiplier: multiplier + 1);
          return;
        }
      }
    }
    ref
        .read(scoreProvider.notifier)
        .incrementScore(multiplier + (multiplier / 30));
    checkIfGameOver();
  }

  void checkIfGameOver() {
    if (state
        .sublist(0, 30)
        .any((element) => element.isBlock && !element.isPlayer)) {
      inGame = false;
      ref.read(gameEndsProvider.notifier).toggle(true);
      ref.read(timerProvider.notifier).startCountdown(8);
    }
  }

  void clearRow(int lastColumn) {
    Map<int, GridValue> goesDown = {};
    for (int i = lastColumn; i > lastColumn - 10; i--) {
      state[i] = blankBox;
    }
    for (int i = lastColumn; i >= initialBlock; i--) {
      if (state[i].isBlock) {
        goesDown[i] = state[i];
      }
      state[i] = blankBox;
    }
    goesDown.forEach((key, value) {
      state[key + 10] = value;
    });
  }

//---------------------Player movements------------------------

  void buttonFunction(String text) async {
    state = await GameButtonLogic(
      currentList: state,
      currentPlayer: findPlayer(state),
      pressedButton: text,
      reserveBlock: (text == 'Switch')
          ? ref.watch(reserveBlockProvider.notifier).state
          : null,
      blockQueue: (text == 'Switch')
          ? ref.watch(blockQueueProvider.notifier).state
          : null,
    ).function();
    if (text == 'Switch') {
      ref
          .read(blockQueueProvider.notifier)
          .swapValue(ref.watch(reserveBlockProvider.notifier).state);
      ref.read(reserveBlockProvider.notifier).reserveBlock();
    }

    if (text == 'Drop') {
      await placeBlock(state, findPlayer(state)).then((value) {
        ref.read(blockQueueProvider.notifier).removeFirstAddAnother();
        return state = value;
      });
      checkRowFull();
      generateBlock();
    }
    updateGrid();
  }

  static Future<LiGrid> moveDown(
      LiGrid currentState, List<int> currentPlayer) async {
    Widget containers = findContainerColor(currentState);

    for (int i = 0; i < currentPlayer.length; i++) {
      currentState[currentPlayer[i]] = GridValue(
          isPlayer: false,
          isBlock: false,
          container: GestureDetector(
              onTap: () {},
              child:
                  Container(color: BlockPicker(colorIndex: 0).getColorBlock)));
    }
    for (int i = 0; i < currentPlayer.length; i++) {
      currentState[currentPlayer[i] + 10] =
          GridValue(isPlayer: true, isBlock: true, container: containers);
    }

    return currentState;
  }
}
