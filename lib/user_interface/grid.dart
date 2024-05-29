import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tetris_flutter/user_interface/blocks.dart';

class GridBlock extends ConsumerStatefulWidget {
  const GridBlock({super.key});

  @override
  ConsumerState<GridBlock> createState() => _GridBlockState();
}

class _GridBlockState extends ConsumerState<GridBlock> {
  static List<Widget> eachBox = [];
  static int aytemkawnt = 180;
  GridListBuilder? gridList;

  @override
  void initState() {
    for (int i = 0; i < aytemkawnt; i++) {
      eachBox.add(GestureDetector(
        onTap: () {print(i);},
        child: Container(
          color: (i < 170) ? ColorBlockPick(
                  colorIndex:
                      BlockValueGenerator(index: i, itemCount: aytemkawnt)
                          .blockGenerator())
                          .getColorBlock() : Colors.pinkAccent,
        ),
      ));
    }
    gridList = GridListBuilder(eachBox, aytemkawnt);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(crossAxisCount: 10,

    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    crossAxisSpacing: 1.5,
    mainAxisSpacing: 1.5,
    children: gridList?.eachBox != null ? eachBox : [],
    );
  }
}

class GridListBuilder {
  final List<Widget> eachBox;
  final int aytemkawnt;

  GridListBuilder(this.eachBox, this.aytemkawnt);
}


