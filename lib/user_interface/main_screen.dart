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
    'Left',
    'Right',
    'Down',
    'Drop',
    'Shift',
    'Switch',
  ];
  
  List<Widget> _nextBlockLayout = [];

  @override
  void initState() {
    for(int i = 0; i < 5; i++) {_nextBlockLayout.add(NextBlock(i));};
    super.initState();
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 1,
            ),
            Container(
              height: 70,
              width: 70,
              color: Colors.blueAccent,
            ),
            Spacer(
              flex: 1,
            ),
            Expanded(
              flex:12,
              child: Column(
                children: <Widget>[
                    SizedBox(
                      child: GridBlock(),
                      height: 550,
                      width: 300,
                    
                  ),
                  InGameButton(
                    buttonLogic: (text) => print(text),
                    buttonNames: _keysButtons,
                  ),
                ],
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Column(
              children: _nextBlockLayout,
            ),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
