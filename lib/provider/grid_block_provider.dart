import 'dart:async';
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
      GridValue(
          isPlayer: false,
          value: i,
          container:
              Container(color: ColorBlockPick(colorIndex: 0).getColorBlock()))
  ];

  @override
  List<GridValue> build() {
    return blockLayout;
  }

  void automatedDownTimer() {
      generateBlock();
      if (state.where((gridValue) => gridValue.isPlayer).any((_) => true)) {
        Timer.periodic(const Duration(seconds: 2), (timer) {
          if(!Player.inGame) {timer.cancel();}
          final List<int> indices = [];
          for (var i = 0; i < state.length; i++) {
            if (state[i].isPlayer) {
              print(i);
              indices.add(i);
            }
          }
        }
        );
    }
  }

  void generateBlock() {

    for (int i = 4; i < 6; i++) {
      state[i] = GridValue(
          isPlayer: true,
          value: i,
          container:
              Container(color: ColorBlockPick(colorIndex: 1).getColorBlock()));
    }
  }

  void clearRow() {}

  void moveRight() {}

  void moveLeft() {}

  void moveDown() {}

  void rotateBlock() {}

  void dropBlock() {}
}
