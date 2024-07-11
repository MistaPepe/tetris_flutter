import 'package:flutter/material.dart';

class NextBlock extends StatefulWidget {
  final int index;
  const NextBlock(this.index, {super.key});

  @override
  State<NextBlock> createState() => _NextBlockState();
}

class _NextBlockState extends State<NextBlock> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
                  height: 70,
                  width: 70,
                  color: Colors.white12,
              ),
    );
  }
}


class ReserveBlock extends StatefulWidget {
  final int blockReserve;
  const ReserveBlock(this.blockReserve, {super.key});

  @override
  State<ReserveBlock> createState() => _ReserveBlockState();
}

class _ReserveBlockState extends State<ReserveBlock> {
  @override
  Widget build(BuildContext context) {
    return  Container(
                height: 70,
                width: 70,
                color: Colors.white12,
            );
  }
}