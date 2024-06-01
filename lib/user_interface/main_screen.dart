import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tetris_flutter/global.dart' as global;
import 'package:tetris_flutter/provider/grid_block_provider.dart';
import 'package:tetris_flutter/user_interface/buttons.dart';
import 'package:tetris_flutter/user_interface/uppper_row.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  Color theme = Colors.black12;
  List<String> _keysButtons = [
    'Shift',
    'Switch',
    'Left',
    'Right',
    'Down',
    'Drop',
  ];

  List<Widget> _nextBlockLayout = [
    for (int i = 0; i < 5; i++) 
      NextBlock(i)
    ];

final List<Widget> blockLayout = [
  for (int i = 0; i < 180; i++)
    if (global.Player.inGame)
      Container(color: Colors.blueAccent)
    else
      Container(color: Colors.white10),
];

  @override
  void initState() {
    super.initState();
  }

  Widget getPlayButton() {
    if (!global.Player.inGame) {
      return InGameButton(
        buttonLogic: (text) {
     
         setState(() {
      
         });
        },
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
        backgroundColor: theme,
        title: Center(
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
                            child: GridBlock(eachBox: blockLayout),
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
            ),
          ],
        ),
      ),
    );
  }
}

