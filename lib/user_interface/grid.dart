import 'package:flutter/material.dart';

class GridBlock extends StatefulWidget {
  const GridBlock({super.key});

  @override
  State<GridBlock> createState() => _GridBlockState();
}

class _GridBlockState extends State<GridBlock> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(100, 1, 100, 1),
      child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
      itemCount: 180, 
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(2),
          child: Container(
            color: Colors.white10,
            constraints: BoxConstraints(maxHeight: 10, maxWidth: 10),
           ),
        );
      },),
    );
  }
}