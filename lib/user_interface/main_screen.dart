import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tetris_flutter/provider/blank_boxes_provider.dart';
import 'package:tetris_flutter/provider/global.dart';
import 'package:tetris_flutter/provider/grid_block_provider.dart';
import 'package:tetris_flutter/user_interface/blocks.dart';
import 'package:tetris_flutter/user_interface/buttons.dart';
import 'package:tetris_flutter/user_interface/reserve_next_box.dart';


class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  //general variable


  final Map<String, Color> theme = {"background": Colors.black12};


  //buttons and keyboard
  static const List<String> _keysButtons = [
    'Rotate',
    'Switch',
    'Left',
    'Right',
    'Down',
    'Drop',
  ];

  Widget keyboardKeys(Widget body) {
    return Shortcuts(
        shortcuts: <ShortcutActivator, Intent>{
          LogicalKeySet(LogicalKeyboardKey.arrowDown): const DownIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowLeft): const LeftIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowRight): const RightIntent(),
          LogicalKeySet(LogicalKeyboardKey.keyZ): const RotateIntent(),
          LogicalKeySet(LogicalKeyboardKey.keyX): const SwitchIntent(),
          LogicalKeySet(LogicalKeyboardKey.space): const DropIntent(),
        },
        child: Actions(actions: {
          DownIntent: CallbackAction(
              onInvoke: (intent) =>
                  ref.read(gridProvider.notifier).buttonFunction('Down')),
          LeftIntent: CallbackAction(
              onInvoke: (intent) =>
                  ref.read(gridProvider.notifier).buttonFunction('Left')),
          RightIntent: CallbackAction(
              onInvoke: (intent) =>
                  ref.read(gridProvider.notifier).buttonFunction('Right')),
          RotateIntent: CallbackAction(
              onInvoke: (intent) =>
                  ref.read(gridProvider.notifier).buttonFunction('Rotate')),
          SwitchIntent: CallbackAction(
              onInvoke: (intent) =>
                  ref.read(gridProvider.notifier).buttonFunction('Switch')),
          DropIntent: CallbackAction(
              onInvoke: (intent) =>
                  ref.read(gridProvider.notifier).buttonFunction('Drop')),
        }, child: Focus(child: body)));
  }

  //start and stop buttons
  Widget getPlayButton() {
    return (inGame)
        ? InGameButton(
            buttonLogic: (text) {
              setState(() {
                if (text == 'Stop') {
                  inGame = false;
                } else {
                  ref.read(gridProvider.notifier).buttonFunction(text);
                }
              });
            },
            buttonNames: _keysButtons,
          )
        : StartButton(
            onTapButton: () async {
              setState(() {
                ref.read(scoreProvider.notifier).reset();
                ref.read(gameEndsProvider.notifier).toggle(false);
                ref.read(timerProvider.notifier).startCountdown(3);
                inGame = true;
              });
              Future.delayed(const Duration(seconds: 4), () {
                ref.read(gridProvider.notifier).startGame();
              });
            },
            textStartbutton: "Start",
          );
  }

  @override
  Widget build(BuildContext context) {
    List<int> blockQueue = ref.watch(blockQueueProvider);
    int countdown = ref.watch(timerProvider);
    List<Widget> nextBlockLayout = [
      for (int i = 0; i < 5; i++)
        if (i < blockQueue.length)
          NextBlock(index: blockQueue[i + 1])
        else
          const NextBlock(index: null)
    ];
    return Scaffold(
        backgroundColor: theme["background"],
        appBar: AppBar(
          backgroundColor: theme["background"],
          title: const Center(
              child: Text(
            'Tetris',
            style: TextStyle(color: Colors.white),
          )),
        ),
        body: keyboardKeys(
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    color: BlockPicker(colorIndex: 0).getColorBlock,
                    width: 90,
                    height: 30,
                    child: FittedBox(
                      child: Text(
                        'Score: ${ref.watch(scoreProvider).toInt()}',
                        style: TextStyle(
                            color: BlockPicker(
                                    colorIndex: (blockQueue.isEmpty)
                                        ? 8
                                        : blockQueue[0])
                                .getColorBlock),
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: SizedBox(
                        width: 500,
                        height: 1000,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Spacer(
                                  flex: 1,
                                ),
                                Flexible(
                                    flex: 7,
                                    child: ReserveBlock(
                                        index:
                                            ref.watch(reserveBlockProvider))),
                                const Spacer(
                                  flex: 1,
                                ),
                                Expanded(
                                  flex: 30,
                                  child: Stack(
                                    children: [
                                      GridBlock(
                                        eachBox: ref
                                            .watch(gridProvider)
                                            .map((item) => item.container)
                                            .toList(),
                                      ),
                                      if (countdown > 0 && inGame == true)
                                        Positioned.fill(
                                          child: Center(
                                            child: Text(
                                              countdown.toString(),
                                              style: const TextStyle(
                                                  fontSize: 100.0,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      if (countdown > 4 &&
                                          ref.watch(gameEndsProvider))
                                        const Positioned.fill(
                                          child: Center(
                                            child: Text(
                                              'Game Over',
                                              style: TextStyle(
                                                  fontSize: 100.0,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      if (countdown < 4 &&
                                          ref.watch(gameEndsProvider))
                                        Positioned.fill(
                                          child: Center(
                                            child: Text(
                                              'Your Score: ${ref.watch(scoreProvider).toInt()}',
                                              style: const TextStyle(
                                                  fontSize: 80.0,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                Flexible(
                                  flex: 7,
                                  child: Column(
                                    children: nextBlockLayout,
                                  ),
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                              ],
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            Flexible(
                              flex: 12,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: SizedBox(child: getPlayButton()),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}


class DownIntent extends Intent {
  const DownIntent();
}

class LeftIntent extends Intent {
  const LeftIntent();
}

class RightIntent extends Intent {
  const RightIntent();
}

class RotateIntent extends Intent {
  const RotateIntent();
}

class SwitchIntent extends Intent {
  const SwitchIntent();
}

class DropIntent extends Intent {
  const DropIntent();
}
