import 'package:flutter/material.dart';
import 'package:tetris_flutter/functions/button_function.dart';
import 'package:tetris_flutter/global.dart';
import 'package:tetris_flutter/user_interface/buttons.dart';
import 'package:tetris_flutter/user_interface/uppper_row.dart';
import 'package:tetris_flutter/user_interface/grid.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> _keysButtons = [
    'Shift',
    'Switch',
    'Left',
    'Right',
    'Down',
    'Drop',
  ];

  List<Widget> _nextBlockLayout = [];

  @override
  void initState() {
    for (int i = 0; i < 5; i++) {
      _nextBlockLayout.add(NextBlock(i));
    }
    super.initState();
  }

  Widget getPlayButton() {
    if (!Player.inGame) {
      return InGameButton(
        buttonLogic: (text) => print(text),
        buttonNames: _keysButtons,
      );
    } else {
      return StartButton(onTapButton: (){},textStartbutton: "Start",);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Center(
            child: Text(
          'Tetris',
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  Flexible(child: ReserveBlock(0), flex: 7),
                  Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 30,
                    child: GridBlock(),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Flexible(
                    flex: 7,
                    child: Column(
                      children: _nextBlockLayout,
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                ],
              ),
              Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: getPlayButton(),
                        ),
          ],
        ),
      ),
    );
  }
}
