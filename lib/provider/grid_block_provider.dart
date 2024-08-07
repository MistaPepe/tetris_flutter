import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tetris_flutter/global.dart';
import 'package:tetris_flutter/provider/button_function.dart';
import 'package:tetris_flutter/user_interface/blocks.dart';

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
  final int initialBlock = 30;
  LiGrid initialBlockLayout() {
    return [
      for (int i = 0; i < 220; i++)
        GridValue(
            isPlayer: false,
            isBlock: false,
            container: GestureDetector(
                onTap: () {
                  print(i);
                },
                child:
                    Container(color: BlockPicker(colorIndex: 0).getColorBlock)))
    ];
  }

  @override
  LiGrid build() {
    return initialBlockLayout();
  }

// --------------automatic and repeating code-----------------

  void startGame() async {
    await generateBlock();
    updateGrid();
    automatedDownTimer();
    if (!Player.inGame) {
      state = initialBlockLayout();
      updateGrid();
    }
  }

  static late int currentBlock;

  List<int> checkRowFull(LiGrid currentState) {
    List<int> placeholder = [];
    for (int i = initialBlock; i < 230; i += 10) {
      int holder = 0;
      for (int row = i; row <= i + 10; row++) {
        if (currentState[row].isBlock) {
          holder++;
        }
        if (holder == 10) {
          placeholder.add(i);
        }
      }
    }
    return placeholder;
  }

  void automatedDownTimer() {
    updateGrid();
    // find if there are any player block in the state
    if (state.where((gridValue) => gridValue.isPlayer).any((_) => true)) {
      if (Player.inGame) {
        Timer.periodic(const Duration(milliseconds: 2000), (timer) {
          if (!Player.inGame) {
            state = initialBlockLayout();
            timer.cancel();
            updateGrid();
            return; // important to cancel timer immediately
          }
          //logic for blocks automatic down

          if (isValidPlace(state, findPlayer(), 'Down')) {
            moveDown(state, findPlayer()).then((value) => state = value);
          } else {
            timer.cancel();
            Future.delayed(const Duration(seconds: 3), () async {
              await placeBlock(state, findPlayer()).then((value) => value);
              startGame();
            });
          }
          updateGrid();
        });
      }
    }
  }

//TODO: fucking hell
  void highLightDrop() {
    // logic for highlighting drop zone
    List<int> player = findPlayer();
    while (isValidPlace(state, player, 'Down')) {
      for (int i = 0; i < 4; i++) {
        player[i] += 10;
      }
    }
    for (int p in player) {
      state[p] = GridValue(
        isPlayer: false,
        isBlock: false,
        container: GestureDetector(
            onTap: () {
              print('Block tapped');
            },
            child: Container(
                color: BlockPicker(colorIndex: currentBlock)
                    .getHighLightedColorBlock)),
      );
    }
  }

// --------------event codes (validity, generating, and removing of blocks)-----------------
  void updateGrid() {
    highLightDrop();
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
    List<int> left() => [for (int i = 30; i <= 200; i += 10) i];

    List<int> right() => [for (int i = 39; i <= 209; i += 10) i];

    List<int> bottom() => [for (int i = 200; i <= 209; i++) i];

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

    if (movement == "Shift") {
      int i = 0;
      int r = 0;
      if (left().any((element) => currentPlayer.contains(element))) i++;
      if (right().any((element) => currentPlayer.contains(element))) r++;
      if (i != 0 && r != 0) return false;
    }

    return result ?? true;
  }

  Future<LiGrid> placeBlock(
      LiGrid currentState, List<int> currentPlayer) async {
    Widget containers = findContainerColor(currentState);
    for (int i in currentPlayer) {
      currentState[i] =
          GridValue(isPlayer: false, isBlock: true, container: containers);
    }
    return currentState;
  }

  Future generateBlock() async{
    int pick = Random().nextInt(7) + 1;
    currentBlock = pick;
    for (var i in BlockPicker(colorIndex: currentBlock).pickBlock().entries) {
      state[i.key] = GridValue(
          isPlayer: true, isBlock: true, container: Container(color: i.value));
    }
  }

  List<int> findPlayer() => [
        for (var i = 0; i < state.length; i++)
          if (state[i].isPlayer) i
      ];

  static Widget findContainerColor(LiGrid currentState) {
    return currentState.firstWhere((gridValue) => gridValue.isPlayer).container;
  }

  void clearRow() {
    for (int i = 200; i <= 209; i++) {
      print(state[i].isBlock);
    }
    print("end line");
  }

//---------------------Player movements------------------------

  void buttonFunction(String text) async {
    state = await GameButtonLogic(
            currentList: state,
            currentPlayer: findPlayer(),
            pressedButton: text)
        .function();
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
