import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tetris_flutter/global.dart';
import 'package:tetris_flutter/user_interface/blocks.dart';

part 'grid_block_provider.g.dart';

class GridBlock extends StatelessWidget {
  final List<Widget> eachBox;
  const GridBlock({super.key, required this.eachBox});

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
          children: eachBox,
        ),
      ],
    );
  }
}

class GridValue {
  final bool isPlayer;
  final int value;
  final Widget container;
  GridValue(
      {required this.value, required this.container, required this.isPlayer});
}

@riverpod
class Grid extends _$Grid {

  final List<GridValue> blockLayout = [
    for (int i = 0; i < 180; i++)
      if (Player.inGame)
        GridValue(
            isPlayer: true,
            value: i,
            container:
                Container(color: ColorBlockPick(colorIndex: 1).getColorBlock()))
      else
        GridValue(
            isPlayer: true,
            value: i,
            container:
                Container(color: ColorBlockPick(colorIndex: 0).getColorBlock()))
  ];

  @override
  List<GridValue> build() {
    return blockLayout;
  }

  void generateBlock() {
     blockLayout[10] = GridValue(
            isPlayer: true,
            value: 1,
            container:
                Container(color: ColorBlockPick(colorIndex: 2).getColorBlock()));
  }

  void clearRow() {}

  void moveBlock() {}

  void rotateBlock() {}

  void dropBlock() {}
}
