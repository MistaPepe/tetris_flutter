import 'package:flutter/material.dart';
import 'package:tetris_flutter/provider/grid_block_provider.dart';
import 'package:tetris_flutter/user_interface/blocks.dart';

typedef Li = List<int>;

class GameButtonLogic {
  final String pressedButton;
  List<GridValue> currentList;
  final Li currentPlayer;
  GameButtonLogic(
      {required this.currentList,
      required this.currentPlayer,
      required this.pressedButton});

  final blankBox = GridValue(
      isPlayer: false,
      isBlock: false,
      container: Container(color: BlockPicker(colorIndex: 0).getColorBlock));

  final currentBox = GridValue(
      isPlayer: true,
      isBlock: true,
      container: Container(
          color: BlockPicker(colorIndex: Grid.currentBlock).getColorBlock));

  void clearCurrent(Li player) {
    for (int i in player) {
      currentList[i] = blankBox;
    }
  }

  Future<List<GridValue>> function() async {
    if (Grid.isValidPlace(currentList, currentPlayer, pressedButton)) {
      switch (pressedButton) {
        case 'Shift':

          ///-----------------rotate
          rotate();

          /// see below for code
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
          clearCurrent(currentPlayer);
          currentList = Grid.highLightDrop(currentList,
              fromButton: true, providedPlayer: currentPlayer);
          break;
      }
    }
    return currentList;
  }

  ///rotation logic

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
    Li newPlayerList = [];
    int center = 0;
    clearCurrent(currentPlayer);
    switch (Grid.currentBlock) {
      case 1: // i shape rotation
        if (isVertical()) {
          for (int i = 0; i < 4; i++) {
            newPlayerList.add(currentPlayer[2] - 1 + i);
            center = 1;
          }
        } else {
          for (int i = 0; i < 4; i++) {
            newPlayerList.add(currentPlayer[1] - 20 + (i * 10));
            center = 2;
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
            center = 1;
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
            center = 1;
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
            center = 1;
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
            center = 1;
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
            center = 1;
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
            center = 1;
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


    Li isColided(Li checkColision) {
      return [
        for (int i = 30; i < currentList.length; i++)
          if ((currentList[i].isBlock &&
              !currentList[i].isPlayer &&
              checkColision.contains(i)))
            i,
          for(int i = 210; i <= 220; i++) //for below border
          if(checkColision.contains(i))
          i
      ];
    }

    

    Map<int, Li> boxAreaX(int centerBox) {
      return {
        -1: List.generate(3, (l) => centerBox - 11 + (10 * l)),
        0: List.generate(3, (m) => centerBox - 10 + (10 * m)),
        1: List.generate(3, (n) => centerBox - 9 + (10 * n)),
      };
    }

    Map<int, Li> boxAreaY(int centerBox) {
      return {
        -1: List.generate(3, (i) => centerBox + 9 + i),
        0: List.generate(3, (j) => centerBox - 1 + j),
        1: List.generate(3, (k) => centerBox - 11 + k),
      };
    }

    Li checkCollision() {
      for (int i = 0; i < 2; i++) {
        Li holderForChecking = newPlayerList;
        List axisList = [
          boxAreaX(holderForChecking[center]),
          boxAreaY(holderForChecking[center])
        ];
        for (int collided in isColided(holderForChecking)) {
          for (var entry in axisList[i].entries) {
            int adjustment = 0;
            int key = entry.key;
            Li values = entry.value;
            if (values.contains(collided)) {
              switch (key) {
                case -1:
                  (i == 0) ? adjustment = 1 : adjustment = -10;
                  break;
                case 1:
                  (i == 0) ? adjustment = -1 : adjustment = 10;
                  break;
                default:
                  adjustment = -10;
                  break;
              }
            }
            Li adjustmentCheck() {
              return [
                for (int i = 0; i < 4; i++) newPlayerList[i] + adjustment
              ];
            }

            if (isColided(adjustmentCheck()).isEmpty) {
              return holderForChecking = adjustmentCheck();
            }
          }
        }
      }
      return currentPlayer;
    }

    finalRotation() {
      for (int i = 0; i < 4; i++) {
        if (center == i) {
          currentList[newPlayerList[i]] = GridValue(
              isPlayer: true,
              isBlock: true,
              container:
                  Container(color: BlockPicker(colorIndex: 7).getColorBlock));
        } else {
          currentList[newPlayerList[i]] = currentBox;
        }
      }
    }

    var counterAdjustment = 0;

    check() {
      while (!Grid.isValidPlace(currentList, newPlayerList, pressedButton) &&
          counterAdjustment < 4) {
        int location = 0;
        int first = currentPlayer.first;
        while ((first - location) % 10 != 0) {
          location++;
        }
        if (location > 5) {
          for (int i = 0; i < newPlayerList.length; i++) {
            newPlayerList[i] = newPlayerList[i] - 1;
          }
        } else {
          for (int i = 0; i < newPlayerList.length; i++) {
            newPlayerList[i] = newPlayerList[i] + 1;
          }
        }
        counterAdjustment++;
      }

      if (counterAdjustment == 4) {
        for (int i = 0; i < 4; i++) {
          newPlayerList[i] = currentPlayer[i];
        }
        finalRotation();
        return;
      }

      if (isColided(newPlayerList).isNotEmpty) {
        newPlayerList = checkCollision();
        check();
      }

      finalRotation();
    }

    check();
  }
}
