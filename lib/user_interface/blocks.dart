import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tetris_flutter/global.dart';

class BlockValueGenerator {
  int itemCount;
  int index;

  BlockValueGenerator({required this.index, required this.itemCount});

  blockGenerator() {
    int BlockValue = 0;
    for (int i = 0; i < itemCount; i++) {
      BlockValue = Random().nextInt(7);
    }

    return BlockValue;
  }
}

class ColorBlockPick {
  int colorIndex;
  ColorBlockPick({required this.colorIndex});

  List<Color> colorBlock = [
    Colors.lightBlue,
    Color.fromARGB(255, 25, 11, 212),
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.purple,
    Colors.red
  ];

  Color getColorBlock() {
    Color colorOfBlock = Colors.white10;
    if (Player.inGame) {
      for (int i = 0; i < colorIndex; i++) {
        colorOfBlock = colorBlock[i];
      }
    }
    return colorOfBlock;
  }
}

class BlockPicker extends ColorBlockPick {
  final int selection;
  BlockPicker(this.selection) : super(colorIndex: selection);

  @override
  List<Color> get colorBlock => super.colorBlock;

  Switch(selection) {
    switch (selection) {
      case 1:
        return i_block();
      case 2:
        return j_block();
      case 3:
        return l_block();
      case 4:
        return o_block();
      case 5:
        return s_block();
      case 6:
        return t_block();
      default:
        return z_block();
    }
  }

  i_block() {}
  j_block() {}
  l_block() {}
  o_block() {}
  s_block() {}
  t_block() {}
  z_block() {}
}
