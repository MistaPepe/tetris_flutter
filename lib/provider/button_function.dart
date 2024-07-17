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
    List<int> newPlayerList = [];
    int center;
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
      case 2: //  L shape rotation
        if (isVertical()) {
          if (isHanging(Grid.currentBlock)) {
            for (int i = 0; i < 3; i++) {
              newPlayerList.add(currentPlayer[1] - 1 + i);
            }
            newPlayerList.add(currentPlayer[2] - 20);
            center = 1;
          } else {
            for (int i = 0; i < 3; i++) {
              newPlayerList.add(currentPlayer[2] - 1 + i);
            }
            newPlayerList.add(currentPlayer[1] + 20);
            center = 1;
          }
        } else {
          if (isHanging(Grid.currentBlock)) {
            for (int i = 0; i < 3; i++) {
              newPlayerList.add(currentPlayer[2] - 10 + (i * 10));
            }
            newPlayerList.add(currentPlayer[0] + 2);
            center = 2;
          } else {
            for (int i = 0; i < 3; i++) {
              newPlayerList.add(currentPlayer[1] - 10 + (i * 10));
            }
            newPlayerList.add(currentPlayer[3] - 2);
            center = 1;
          }
        }
        break;
      case 3: //  j shape rotation
        if (isVertical()) {
          if (isHanging(Grid.currentBlock)) {
            for (int i = 0; i < 3; i++) {
              newPlayerList.add(currentPlayer[2] - 1 + i);
            }
            newPlayerList.add(currentPlayer[0] + 2);
            center = 2;
          } else {
            for (int i = 0; i < 3; i++) {
              newPlayerList.add(currentPlayer[1] - 1 + i);
            }
            newPlayerList.add(currentPlayer[3] - 2);
            center = 1;
          }
        } else {
          if (isHanging(Grid.currentBlock)) {
            for (int i = 0; i < 3; i++) {
              newPlayerList.add(currentPlayer[1] - 10 + (i * 10));
            }
            newPlayerList.add(currentPlayer[0] - 10);
            center = 1;
          } else {
            for (int i = 0; i < 3; i++) {
              newPlayerList.add(currentPlayer[2] - 10 + (i * 10));
            }
            newPlayerList.add(currentPlayer[0] + 20);
            center = 2;
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
        } else {
          for (int i = 0; i < 2; i++) {
            newPlayerList.add(currentPlayer[0] + (i * 10));
          }
          for (int i = 0; i < 2; i++) {
            newPlayerList.add(currentPlayer[3] + 1 + (i * 10));
          }
        }
        break;
      case 6: //  t shape rotation
        if (isVertical()) {
          if (currentPlayer.last - currentPlayer[1] == 10) {
            for (int i = 0; i < 3; i++) {
              newPlayerList.add(currentPlayer[1] - 1 + i);
            }
            newPlayerList.add(currentPlayer[1] + 10);
          } else {
            for (int i = 0; i < 3; i++) {
              newPlayerList.add(currentPlayer[2] - 1 + i);
            }
            newPlayerList.add(currentPlayer[2] - 10);
          }
        } else {
          if (currentPlayer[1] - currentPlayer.first == 1) {
            for (int i = 0; i < 3; i++) {
              newPlayerList.add(currentPlayer[1] - 10 + (i * 10));
            }
            newPlayerList.add(currentPlayer[1] - 1);
          } else {
            for (int i = 0; i < 3; i++) {
              newPlayerList.add(currentPlayer[2] - 10 + (i * 10));
            }
            newPlayerList.add(currentPlayer[2] + 1);
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
        } else {
          for (int i = 0; i < 2; i++) {
            newPlayerList.add(currentPlayer[1] + 1 + i * 10);
          }
          for (int i = 0; i < 2; i++) {
            newPlayerList.add(currentPlayer[2] + i * 10);
          }
        }
        break;
    }
    const List<int> adjustmentMove = [1, -1, 10, -10, -20, -21, 11, -11, 2 ,-2, 20,  21];
    int counter = -1;
    List<int> holderForChecking = newPlayerList;
    check() {
      while (
          !Grid.isValidPlace(currentList, holderForChecking, pressedButton) &&
              counter <= adjustmentMove.length) {
        counter++;
        print(holderForChecking);
        for (int index = 0; index < 4; index++) {
          holderForChecking[index] =
              newPlayerList[index] + adjustmentMove[counter];
        }
      }
      if (counter != -1) {
        newPlayerList = holderForChecking;
      }
      for (int i in newPlayerList) {
        currentList[i] = currentBox;
      }
    }

    check();
  }
}
