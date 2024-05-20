import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
              flex: 1,
              child: Text(
                'Press Z to store. Press Space to drop. Left, Down, and Right arrow key to navigate. Shift to switch',
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 60,
              width: 120,
              child: OutlinedButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text('Start'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InGameButton extends StatefulWidget {

  final Function buttonLogic;
  final List<String> buttonNames;

  InGameButton({
    required this.buttonLogic,
    required this.buttonNames,
  });

  @override
  State<InGameButton> createState() => _InGameButtonState();
}

class _InGameButtonState extends State<InGameButton> {
  List<Widget> buttonsList = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.buttonNames.length; i++) {
      buttonsList.add(
       Padding(
          padding: const EdgeInsets.fromLTRB(0,3,0,3),
          child: SizedBox(
            height: 60,
            width: 70,
            child: OutlinedButton(
              onPressed: () => widget.buttonLogic(widget.buttonNames[i]),
              child: Text(widget.buttonNames[i]),
          ),
              ),
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          width: 300,
          child: GridView.count(
            childAspectRatio: 2.5,
            crossAxisCount: 2,
            children: buttonsList,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    'Press Z to store. Press Space to drop. Left, Down, and Right arrow key to navigate. Shift to rotate',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 60,
                  width: 120,
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        Status.inGame = !Status.inGame;
                      });
                    },
                    child: Text('Stop'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
