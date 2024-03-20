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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
              padding: const EdgeInsets.fromLTRB(100, 1, 100, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: SizedBox(height: 40, width: 60, 
                    child: OutlinedButton(onPressed: (){
                      setState(() {
                     
                      });
                    }, child: Text('butu',),),),),
                    Expanded(
                    child: SizedBox(height: 50, width: 60, 
                    child: OutlinedButton(onPressed: (){
                      setState(() {
         
                      });
                    }, child: Text('butu'),),),
                  ),
                ],
              ),
            ),
        Padding(
              padding: const EdgeInsets.fromLTRB(100, 1, 100, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: SizedBox(height: 50, width: 60, 
                    child: OutlinedButton(onPressed: (){
                      setState(() {
                        
                      });
                    }, child: Text('butu'),),),),
                    Expanded(
                    child: SizedBox(height: 50, width: 60, 
                    child: OutlinedButton(onPressed: (){
                      setState(() {
                       
                      });
                    }, child: Text('butu'),),),
                  ),
                ],
              ),
            ),
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