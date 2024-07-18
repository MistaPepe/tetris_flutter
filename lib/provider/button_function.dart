import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:tetris_flutter/provider/grid_block_provider.dart';
import 'package:tetris_flutter/user_interface/blocks.dart';

class GameButtonLogic {
  final String pressedButton;
  List<GridValue> currentList;
  final List<int> currentPlayer;
  GameButtonLogic(
      {required this.currentList,
      required this.currentPlayer,
      required this.pressedButton});

  final blankBox = GridValue(
      isPlayer: false,
      isBlock: false,
      container: Container(color: BlockPicker(colorIndex: 0).getColorBlock()));

  final currentBox = GridValue(
      isPlayer: true,
      isBlock: true,
      container: Container(
          color: BlockPicker(colorIndex: Grid.currentBlock).getColorBlock()));

  void clearCurrent(List<int> player) {
    for (int i in player) {
      currentList[i] = blankBox;
    }
  }

  List<GridValue> function() {
    if (Grid.isValidPlace(currentList, currentPlayer, pressedButton)) {
      switch (pressedButton) {
        case 'Shift': //-----------------rotate
          rotate();
          break;
        case 'Switch':
          break;
        case 'Left':
          clearCurrent(currentPlayer);
          for (int i in currentPlayer) {
            currentList[i - 1] = currentBox;
          }
          break;
        case 'Right':
          clearCurrent(currentPlayer);
          for (int i in currentPlayer) {
            currentList[i + 1] = currentBox;
          }
          break;
        case 'Down':
          Grid.moveDown(currentList, currentPlayer)
              .then((value) => currentList = value);
          break;
        case 'Drop':
          break;
      }
    }
    return currentList;
  }

  bool isVertical() {
    return (currentPlayer.last - currentPlayer.first > 15) ? true : false;
  }

  bool isHanging(int shape) {
    if (currentPlayer.last - currentPlayer[2] == 1 && shape == 2) {
      return true;
    }
    if (currentPlayer[1] - currentPlayer.first == 1 && shape == 3) {
      return true;
    } else {
      return false;
    }
  }

  rotate() {
    ///Reference https://tetris.fandom.com/wiki/SRS?file=SRS-pieces.png
    List<int> newPlayerList = [];
    int center = 0;
    clearCurrent(currentPlayer);
    switch (Grid.currentBlock) {
      case 1: // i shape rotation
        if (isVertical()) {
          for (int i = 0; i < 4; i++) {
            newPlayerList.add(currentPlayer[2] - 1 + i);
            center = 2;
          }
        } else {
          for (int i = 0; i < 4; i++) {
            newPlayerList.add(currentPlayer[1] - 20 + (i * 10));
            center = 1;
          }
        }
        break;
      case 2: //  j shape rotation
        if (isVertical()) {
          if (isHanging(Grid.currentBlock)) {
            /// Reference: Last rotation
            for (int i = 0; i < 3; i++) {
              newPlayerList.add(currentPlayer[1] - 1 + i);
            }
            newPlayerList.add(currentPlayer[2] - 20);
            center = 2;
          } else {
            /// Reference: 2nd rotation
            for (int i = 0; i < 3; i++) {
              newPlayerList.add(currentPlayer[2] - 1 + i);
            }
            newPlayerList.add(currentPlayer[1] + 20);
            center = 1;
          }
        } else {
          if (isHanging(Grid.currentBlock)) {
            for (int i = 0; i < 3; i++) {
              /// Reference: 1st rotation
              newPlayerList.add(currentPlayer[2] - 10 + (i * 10));
            }
            newPlayerList.add(currentPlayer[0] + 2);
            center = 2;
          } else {
            /// Reference: 3rd rotation
            for (int i = 0; i < 3; i++) {
              newPlayerList.add(currentPlayer[1] - 10 + (i * 10));
            }
            newPlayerList.add(currentPlayer[3] - 2);
            center = 1;
          }
        }
        break;
      case 3: //  l shape rotation
        if (isVertical()) {
          if (isHanging(Grid.currentBlock)) {
            /// Reference: Last rotation
            for (int i = 0; i < 3; i++) {
              newPlayerList.add(currentPlayer[2] - 1 + i);
            }
            newPlayerList.add(currentPlayer[0] + 2);
            center = 2;
          } else {
            /// Reference: 2nd Rotation
            for (int i = 0; i < 3; i++) {
              newPlayerList.add(currentPlayer[1] - 1 + i);
            }
            newPlayerList.add(currentPlayer[3] - 2);
            center = 1;
          }
        } else {
          /// Reference: 3rd Rotation
          if (isHanging(Grid.currentBlock)) {
            for (int i = 0; i < 3; i++) {
              newPlayerList.add(currentPlayer[1] - 10 + (i * 10));
            }
            newPlayerList.add(currentPlayer[0] - 10);
            center = 2;
          } else {
            /// Reference: 1st rotation
            for (int i = 0; i < 3; i++) {
              newPlayerList.add(currentPlayer[2] - 10 + (i * 10));
            }
            newPlayerList.add(currentPlayer[0] + 20);
            center = 1;
          }
        }
        break; //nmandemonay
      case 4: //  square shape rotation
        for (int i in currentPlayer) {
          newPlayerList.add(i);
        }
        break;
      case 5: //  s shape rotation
        if (isVertical()) {
          for (int i = 0; i < 2; i++) {
            newPlayerList.add(currentPlayer[0] + (i));
          }
          for (int i = 0; i < 2; i++) {
            newPlayerList.add(currentPlayer[0] + 10 - 1 + (i));
          }
          center = 3;
        } else {
          for (int i = 0; i < 2; i++) {
            newPlayerList.add(currentPlayer[0] + (i * 10));
          }
          for (int i = 0; i < 2; i++) {
            newPlayerList.add(currentPlayer[3] + 1 + (i * 10));
          }
          center = 1;
        }
        break;
      case 6: //  t shape rotation
        if (isVertical()) {
          /// Reference 2nd rotation
          if (currentPlayer.last - currentPlayer[1] == 10) {
            for (int i = 0; i < 3; i++) {
              newPlayerList.add(currentPlayer[1] - 1 + i);
            }
            newPlayerList.add(currentPlayer[1] + 10);
            center = 1;
          } else {
            /// Reference last rotation
            for (int i = 0; i < 3; i++) {
              newPlayerList.add(currentPlayer[2] - 1 + i);
            }
            newPlayerList.add(currentPlayer[2] - 10);
            center = 2;
          }
        } else {
          /// Reference 1st rotation
          if (currentPlayer[1] - currentPlayer.first == 1) {
            for (int i = 0; i < 3; i++) {
              newPlayerList.add(currentPlayer[1] - 10 + (i * 10));
            }
            newPlayerList.add(currentPlayer[1] - 1);
            center = 1;
          } else {
            /// Reference 3rd rotation
            for (int i = 0; i < 3; i++) {
              newPlayerList.add(currentPlayer[2] - 10 + (i * 10));
            }
            newPlayerList.add(currentPlayer[2] + 1);
            center = 2;
          }
        }
        break;
      default: //  z shape rotation
        if (isVertical()) {
          for (int i = 0; i < 2; i++) {
            newPlayerList.add(currentPlayer[0] - 1 - i);
          }
          for (int i = 0; i < 2; i++) {
            newPlayerList.add(currentPlayer[1] + i);
          }
          center = 2;
        } else {
          for (int i = 0; i < 2; i++) {
            newPlayerList.add(currentPlayer[1] + 1 + i * 10);
          }
          for (int i = 0; i < 2; i++) {
            newPlayerList.add(currentPlayer[2] + i * 10);
          }
          center = 1;
        }
        break;
    }
    List<int> currentPlaceBlock = currentList
        .where((element) => element.isBlock && !element.isPlayer)
        .map((element) => currentList.indexOf(element))
        .toList();

    List<String> direction = [];

    List<int> holderForChecking = newPlayerList;
    check() {
      if (currentPlaceBlock
          .any((element) => holderForChecking.contains(element))) {
        List<int> collision = currentPlaceBlock
            .where((element) => holderForChecking.contains(element))
            .toList();
        int adjustment = 0;
        for (int blocks in collision) {
          for (int i = 0; i < 4; i++) {
            if (blocks - holderForChecking[i] <= 9) {
              direction.add('down');
            } else if (holderForChecking[i] > blocks) {
              direction.add('right');
            } else if (holderForChecking[i] < blocks) {
              direction.add('left');
            }
          }
          int countRight = 0;
          int countLeft = 0;
          int countDown = 0;

          for (int i = 0; i < direction.length; i++) {
            if (direction[i] == 'down') {
              countDown++;
            } else if (direction[i] == 'right') {
              countRight++;
            } else if (direction[i] == 'left') {
              countLeft++;
            }
          }
          print(collision);
          if(countDown >= 2){adjustment += 10;}
          if(countRight >= 2){adjustment += 1;}
          if(countLeft >= 2){adjustment -= 1;}
          for (int i = 0; i < 4; i++) {
            newPlayerList[i] = holderForChecking[i] + adjustment;
          }
        }
      }
        for (int i in newPlayerList) {
            currentList[i] = currentBox;
          }
    }
    check();
  }
}
