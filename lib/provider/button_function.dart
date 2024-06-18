
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tetris_flutter/provider/grid_block_provider.dart';
import 'package:tetris_flutter/user_interface/blocks.dart';


class GameButtonLogic{
  final WidgetRef ref;
  final String pressedButton;

  GameButtonLogic({required this.pressedButton, required this.ref});


  function(){
    final blockLayout = ref.watch(gridProvider);
    switch(pressedButton){
      case 'Shift':
      ref.read(gridProvider.notifier).state[10] = GridValue(
            isPlayer: true,
            value: 1,
            container:
                Container(color: ColorBlockPick(colorIndex: 7).getColorBlock()));
      break;
      case 'Switch':
      ref.read(gridProvider.notifier).state[10] = GridValue(
            isPlayer: true,
            value: 1,
            container:
                Container(color: ColorBlockPick(colorIndex: 1).getColorBlock()));

      break;
      case 'Left':

      break;
      case 'Right':

      break;
      case 'Down':

      break;
      case 'Drop':

      break;
    }
  }
}

















//example

final counterProvider = StateProvider<int>((ref) => 0);
// Class to modify provider state
class CounterManager {
  final WidgetRef ref;

  CounterManager(this.ref);

  void increment() {
    ref.read(counterProvider.notifier).state++;
  }

  void decrement() {
    ref.read(counterProvider.notifier).state--;
  }
}

// Usage in a ConsumerWidget
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    final counterManager = CounterManager(ref);

    return Scaffold(
      appBar: AppBar(
        title: Text('Counter: $count'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: counterManager.increment,
            child: Text('Increment'),
          ),
          ElevatedButton(
            onPressed: counterManager.decrement,
            child: Text('Decrement'),
          ),
        ],
      ),
    );
  }
}