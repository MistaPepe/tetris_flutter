import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tetris_flutter/provider/grid_block_provider.dart';
import 'package:tetris_flutter/user_interface/blocks.dart';

class GameButtonLogic {
  final String pressedButton;
  final List<GridValue> currentList;
  final List<int> currentPlayer;
  GameButtonLogic(
      {required this.currentList,
      required this.currentPlayer,
      required this.pressedButton});

  final blankBox = GridValue(
      isPlayer: false,
      isBlock: false,
      container:
          Container(color: BlockPicker(colorIndex: 0).getColorBlock()));
  
  List<GridValue> function() {
    if (Grid.isValidPlace(currentList, currentPlayer, pressedButton)) {
      Widget currentBlock = Grid.findContainerColor(currentList);
      switch (pressedButton) {
        case 'Shift': //-----------------rotate
          rotate();
          break;
        case 'Switch':
          break;
        case 'Left':
          for (int i in currentPlayer) {
            currentList[i] = blankBox;
          }
          for (int i in currentPlayer) {
            currentList[i - 1] = GridValue(
                isPlayer: true, isBlock: true, container: currentBlock);
          }
          break;
        case 'Right':
          for (int i in currentPlayer) {
            currentList[i] = blankBox;
          }
          for (int i in currentPlayer) {
            currentList[i + 1] = GridValue(
                isPlayer: true, isBlock: true, container: currentBlock);
          }
          break;
        case 'Down':
          break;
        case 'Drop':
          break;
      }
    } else {}
    return currentList;
  }

  bool isHorizontal() {
    if (currentPlayer.last - currentPlayer.first > 15) {
      return true;
    } else {
      return false;
    }
  }

  rotate() {
    Widget currentBlock = Grid.findContainerColor(currentList);
    switch (Grid.currentBlock) {
      case 1: // l shape rotation
        if (!isHorizontal()) {
          for (int i in currentPlayer) {
            currentList[i] = blankBox;
          }
          for (int i = 0; i < 4; i++) {
            currentList[currentPlayer[1] - 20 + (i * 10)] = GridValue(
                isPlayer: true,
                isBlock: true,
                container: currentBlock);
          }
        } else {
          for (int i in currentPlayer) {
            currentList[i] = blankBox;
          }
          for (int i = 0; i < 4; i++) {
            currentList[currentPlayer[2] - 1 + (i)] = GridValue(
                isPlayer: true,
                isBlock: true,
                container: currentBlock);
          }
        }
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
      case 5:
        break;
      case 6:
        break;
      default:
        break;
    }
  }
}
