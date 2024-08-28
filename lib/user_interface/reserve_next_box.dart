
import 'package:flutter/material.dart';



class NextBlock extends _BlockBox {
  const NextBlock({super.key, super.index});
}

class ReserveBlock extends _BlockBox {
  const ReserveBlock({super.key, super.index});
}

abstract class _BlockBox extends StatelessWidget {
  final int? index;
  const _BlockBox({this.index, super.key});

  static const _imagePath = {
    1: 'lib/src/straight block.png',
    2: 'lib/src/j block.png',
    3: 'lib/src/L block.png',
    4: 'lib/src/square block.png',
    5: 'lib/src/s block.png',
    6: 'lib/src/t block.png',
    7: 'lib/src/z block.png',
  };

  String get imagePath {
    return _imagePath[index].toString();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 70,
        height: 70,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Container(
            height: 70,
            width: 70,
            color: Colors.white12,
            child: Image.asset(
              (index == null || index == 0) ?
              'lib/src/blank.png': imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ));
  }
}
