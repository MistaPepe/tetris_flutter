import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tetris_flutter/global.dart' as global;
import 'package:tetris_flutter/provider/grid_block_provider.dart';
import 'package:tetris_flutter/user_interface/buttons.dart';
import 'package:tetris_flutter/user_interface/uppper_row.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final Map<String, Color> theme = {"background": Colors.black12};

  final List<String> _keysButtons = [
    'Shift',
    'Switch',
    'Left',
    'Right',
    'Down',
    'Drop',
  ];

  List<Widget> nextBlockLayout = [
    for (int i = 0; i < 5; i++) NextBlock(i)
  ];

  List<Widget> blockLayout = [
    for (int i = 0; i < 180; i++)
      if (global.Player.inGame)
        Container(color: Colors.blueAccent)
      else
        Container(color: Colors.white10),
  ];

  Widget getPlayButton() {
    if (global.Player.inGame) {
      return InGameButton(
        buttonLogic: (text) {
            setState(() {
              global.Player.inGame =!global.Player.inGame;
            });
        },
        buttonNames: _keysButtons,
      );
    } else {
      return StartButton(
        onTapButton: () {
          setState(() {
            global.Player.inGame = !global.Player.inGame;
          });
        },
        textStartbutton: "Start",
      );
    }
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
      body: SingleChildScrollView(
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
                        const Flexible(flex: 7,child: ReserveBlock(0)),
                        const Spacer(
                          flex: 1,
                        ),
                        Expanded(
                          flex: 30,
                          child: GridBlock(eachBox: blockLayout),
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
      ),
    );
  }
}
