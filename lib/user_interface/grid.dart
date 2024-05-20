import 'dart:math';

import 'package:flutter/material.dart';

class GridBlock extends StatefulWidget {
  const GridBlock({super.key});

  @override
  State<GridBlock> createState() => _GridBlockState();
}

class _GridBlockState extends State<GridBlock> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
      itemCount: 180,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(1),
          child: Container(
            color: ColorBlockPick(0).getColorBlock(),
            constraints: BoxConstraints(maxHeight: 10, maxWidth: 10),
          ),
        );
      },
    );
  }
}

class ColorBlockPick {
  final int colorIndex;
  ColorBlockPick(this.colorIndex);

  List<Color> colorBlock = [
    Colors.lightBlue,
    Color.fromARGB(255, 25, 11, 212),
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.purple,
    Colors.red
  ];
  
  Color getColorBlock(){
    Color placeHolderColor = Colors.white10;
    for(int i = 0; i < colorIndex; i++){
      placeHolderColor = colorBlock[i];
    }
    return placeHolderColor;
  }
}

class BlockList{

}
