import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tetris_flutter/global.dart' as global;
import 'package:tetris_flutter/provider/grid_block_provider.dart';
import 'package:tetris_flutter/user_interface/blocks.dart';
import 'package:tetris_flutter/user_interface/buttons.dart';
import 'package:tetris_flutter/user_interface/uppper_row.dart';


class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {



  //general variable
  int _countTimer = 0;
  final Map<String, Color> theme = {"background": Colors.black12};

  //timer variable
  void _startCountdown(int setter) {
    _countTimer = setter;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _countTimer--;
        if (_countTimer == 0) {
          timer.cancel();
        }
      });
    });
  }

  //buttons and keyboard
  static const List<String> _keysButtons = [
    'Shift',
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
      LogicalKeySet(LogicalKeyboardKey.keyZ): const ShiftIntent(),
      LogicalKeySet(LogicalKeyboardKey.keyX): const SwitchIntent(),
      LogicalKeySet(LogicalKeyboardKey.space): const DropIntent(),

    }, child: Actions(actions: {
      DownIntent:CallbackAction(onInvoke: (intent) =>
        ref.read(gridProvider.notifier).buttonFunction('Down')),
        LeftIntent:CallbackAction(onInvoke: (intent) =>
        ref.read(gridProvider.notifier).buttonFunction('Left')),
        RightIntent:CallbackAction(onInvoke: (intent) =>
        ref.read(gridProvider.notifier).buttonFunction('Right')),
        ShiftIntent:CallbackAction(onInvoke: (intent) =>
        ref.read(gridProvider.notifier).buttonFunction('Shift')),
        SwitchIntent:CallbackAction(onInvoke: (intent) =>
        ref.read(gridProvider.notifier).buttonFunction('Switch')),
        DropIntent:CallbackAction(onInvoke: (intent) =>
        ref.read(gridProvider.notifier).buttonFunction('Drop')),
    }, child: Focus(child: body)));
  }


  //next block
  List<Widget> nextBlockLayout = [for (int i = 0; i < 5; i++) NextBlock(i)];

  //start and stop buttons
  Widget getPlayButton() {
    return 
    (global.Player.inGame)
        ?  InGameButton(
            buttonLogic: (text) {
              setState(() {
                if (text == 'Stop') {
                  global.Player.inGame = !global.Player.inGame;
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
                _startCountdown(3);
                global.Player.inGame = !global.Player.inGame;
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
        child: Row(
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
                        const Flexible(flex: 7, child: ReserveBlock(0)),
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
                              if (_countTimer > 0)
                                Positioned.fill(
                                  child: Center(
                                    child: Text(
                                      _countTimer.toString(),
                                      style: const TextStyle(
                                          fontSize: 100.0, color: Colors.white),
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
      ),)
    );
  }
}


class DownIntent extends Intent{
  const DownIntent();
}
class LeftIntent extends Intent{
  const LeftIntent();
}
class RightIntent extends Intent{
  const RightIntent();
}
class ShiftIntent extends Intent{
  const ShiftIntent();
}
class SwitchIntent extends Intent{
  const SwitchIntent();
}
class DropIntent extends Intent{
  const DropIntent();
}
