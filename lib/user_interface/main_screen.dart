
import 'package:flutter/material.dart';
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


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
    appBar: AppBar(
      backgroundColor: Colors.black12,
      title: Center(child: Text('Tetris', 
        style: TextStyle(color: Colors.white),)),
    ),
    body: SingleChildScrollView(child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ReserveBlock(),
              NextBlock(),
             ],
          ),
        SizedBox(child: GridBlock(), height: 550, width: 500,),
        (Status.inGame == false) ? startButton() : InGameButton(),
        ],
      ),
    ),
    );
  }
}