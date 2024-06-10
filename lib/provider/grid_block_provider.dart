import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tetris_flutter/global.dart';

class GridBlock extends StatefulWidget {
  
  final List<Widget> eachBox;
  const GridBlock({super.key, required this.eachBox});


  @override
  State<GridBlock> createState() => _GridBlockState();
}

class _GridBlockState extends State<GridBlock> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.count(crossAxisCount: 10,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisSpacing: 1.8,
        mainAxisSpacing: 1.8,
        children: widget.eachBox,
        ),
      ],
    );
  }
}

  final List<Widget> blockLayout = [
    for (int i = 0; i < 180; i++)
      if (Player.inGame)
        Container(color: Colors.blueAccent)
      else
        Container(color: Colors.white10),
  ];

@riverpod
List<Widget> gridBlockLayout(ref) {return blockLayout;}