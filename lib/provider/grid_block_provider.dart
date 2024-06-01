import 'package:flutter/material.dart';

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
