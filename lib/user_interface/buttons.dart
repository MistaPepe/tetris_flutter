import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tetris_flutter/global.dart';

class startButton extends StatefulWidget {

  @override
  State<startButton> createState() => _startButtonState();
}

class _startButtonState extends State<startButton> {


  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.fromLTRB(90, 30, 90, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex:1,
                child: Text('Press Z to store. Press Space to drop. Left, Down, and Right arrow key to navigate')),
              Expanded(
                flex:2,
                child: SizedBox(height: 60, width: 120, 
                child: OutlinedButton(onPressed: (){
                  setState(() {
                   Status.inGame = !Status.inGame;
                  });
                }, child: Text('Start'),),),
              ),
            ],
          ),
        );
  }
  
}



class InGameButton extends StatefulWidget {
 

  @override
  State<InGameButton> createState() => _InGameButtonState();
}

class _InGameButtonState extends State<InGameButton> {


  List<String> _label = ['Shift','left','right','down','rotate'];


    
  Widget _buttons (){
    return 
        Padding(
              padding: const EdgeInsets.fromLTRB(100, 1, 100, 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                 SizedBox(height: 50, width: 100, 
                    child: OutlinedButton(onPressed: (){
                      setState(() {
                     
                      });
                    }, child: Text('butu',),),),
                    Flexible(
                    child: SizedBox(height: 50, width: 100, 
                    child: OutlinedButton(onPressed: (){
                      setState(() {
         
                      });
                    }, child: Text('butu'),),),
                  ),
                ],
              ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        _buttons(),
        _buttons(),
        Padding(
              padding: const EdgeInsets.fromLTRB(90, 1, 90, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex:1,
                    child: Text('Press Z to store. Press Space to drop. Left, Down, and Right arrow key to navigate')),
                  Expanded(
                    flex:2,
                    child: SizedBox(height: 60, width: 120, 
                    child: OutlinedButton(onPressed: (){
                      setState(() {
                      Status.inGame = !Status.inGame;
                      });
                    }, child: Text('Stop'),),),
                  ),
                ],
              ),
            ),
      ],
    );
  }
}