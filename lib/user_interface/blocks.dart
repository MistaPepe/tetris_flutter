// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

abstract class ColorBlockPick {
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
    Colors.red,
  ];

 static const List<Color> highLightedBlock = [
    Color.fromARGB(136, 118, 212, 255),
    Color.fromARGB(143, 104, 97, 207),
    Color.fromARGB(123, 255, 187, 86),
    Color.fromARGB(113, 255, 240, 107),
    Color.fromARGB(127, 126, 170, 128),
    Color.fromARGB(176, 154, 99, 163),
    Color.fromARGB(122, 229, 137, 130),
  ];

  Color get getColorBlock {
    return colorBlock[colorIndex];
  }

  Color get getHighLightedColorBlock {
    return highLightedBlock[colorIndex-1];
  }
}

class BlockPicker extends ColorBlockPick {

  BlockPicker({required super.colorIndex});

  Map<int, Color> pickBlock() {
    switch (colorIndex) {
      case 1: // Straight Block
        return {
          33: colorBlock[colorIndex],
          34: colorBlock[colorIndex],
          35: colorBlock[colorIndex],
          36: colorBlock[colorIndex],
        };
      case 2: // J Block
        return {
          33: colorBlock[colorIndex],
          34: colorBlock[colorIndex],
          35: colorBlock[colorIndex],
          45: colorBlock[colorIndex],
        };
      case 3: // L Block
        return {
          33: colorBlock[colorIndex],
          34: colorBlock[colorIndex],
          35: colorBlock[colorIndex],
          43: colorBlock[colorIndex],
        };
      case 4: // Square Block
        return {
          34: colorBlock[colorIndex],
          35: colorBlock[colorIndex],
          44: colorBlock[colorIndex],
          45: colorBlock[colorIndex],
        };
      case 5:
        return {
          // S Block
          34: colorBlock[colorIndex],
          35: colorBlock[colorIndex],
          43: colorBlock[colorIndex],
          44: colorBlock[colorIndex],
        };
      case 6:
        return {
          // T Block
          34: colorBlock[colorIndex],
          43: colorBlock[colorIndex],
          44: colorBlock[colorIndex],
          45: colorBlock[colorIndex],
        };
      default:
        return {
          // Z block
          33: colorBlock[colorIndex],
          34: colorBlock[colorIndex],
          44: colorBlock[colorIndex],
          45: colorBlock[colorIndex],
        };
    }
  }
}

class GridBlock extends StatelessWidget {
  final List<Widget> eachBox;
  const GridBlock({super.key, required this.eachBox});

  set setEachBox(List<Widget> containers) {
    for (int i = containers.length; i > 210; i--) {
      eachBox.removeAt(i - 1);
    }
    for (int i = 29; i >= 0; i--) {
      eachBox.removeAt(i);
    }
  }

  List<Widget> get getVisibleBox => setEachBox = eachBox;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.count(
          crossAxisCount: 10,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisSpacing: 1.8,
          mainAxisSpacing: 1.8,
          children: getVisibleBox,
        ),
      ],
    );
  }
}
