import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
/// the providers for queue of blocks or what are the next blocks
/// and provider for the reserve or what the player stored block

/// Next Block Provider
class BlockQueue extends Notifier<List<int>> {
  @override
  List<int> build() {
    return [];
  }

  void firstGenerateQueue() {
    state = List.generate(
        6,
        (index) =>
            // 1);
            Random().nextInt(7) + 1);
  }

  void removeFirstAddAnother() {
    state = [...state.sublist(1), Random().nextInt(7) + 1];
  }

  void emptyQueue() {
    state = [];
  }

  void swapValue(int value) {
    state = (value == 0)
        ? [
            ...state.sublist(1),
            Random().nextInt(7) + 1,
          ]
        : [value, ...state.sublist(1)];
  }
}

final blockQueueProvider =
    NotifierProvider<BlockQueue, List<int>>(() => BlockQueue());

// Reserve Block Provider

class ReserveBox extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  static int reserveForNonConsumer = 0;

  void restartBlock() {
    state = 0;
  }

  void reserveBlock() {
    state = reserveForNonConsumer;
  }
}

final reserveBlockProvider =
    NotifierProvider<ReserveBox, int>(() => ReserveBox());
