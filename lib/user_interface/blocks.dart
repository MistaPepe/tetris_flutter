import 'package:flutter/material.dart';


class ColorBlockPick {
  final int colorIndex;
  ColorBlockPick({required this.colorIndex});

  final List<Color> colorBlock = [
    Colors.white10,
    Colors.lightBlue,
   const Color.fromARGB(255, 25, 11, 212),
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.purple,
    Colors.red
  ];
  

  Color getColorBlock() {
    return colorBlock[colorIndex];
  }
}

class BlockPicker extends ColorBlockPick {
  final int selection;
  BlockPicker(this.selection) : super(colorIndex: selection);
  

  @override
  List<Color> get colorBlock => super.colorBlock;

  pickBlock() {
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


