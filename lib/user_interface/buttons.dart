import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Button to start the game -----------------------------------------------------
class StartButton extends StatelessWidget {
  final String textStartbutton;
  final Function onTapButton;
  const StartButton(
      {super.key, required this.textStartbutton, required this.onTapButton});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const Expanded(
              flex: 3,
              child: Text(
                'Left, Down, and Right arrow key to navigate. Z to rotate. X to switch. Press Space to drop.',
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
                onPressed: () => onTapButton(),
                child: Text(textStartbutton),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}


// Buttons for control and stop button ----------------------------------------
class InGameButton extends ConsumerStatefulWidget {
  final Function buttonLogic;
  final List<String> buttonNames;

  const InGameButton({
    super.key,
    required this.buttonLogic,
    required this.buttonNames,
  });

  @override
  ConsumerState<InGameButton> createState() => _InGameButtonState();
}

class _InGameButtonState extends ConsumerState<InGameButton> {

  List<Widget> getButtonsList() {
    return List.generate(widget.buttonNames.length, (i) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
        child: SizedBox(
          height: 60,
          width: 70,
          child: OutlinedButton(
            onPressed: () => widget.buttonLogic(widget.buttonNames[i]),
            child: Text(widget.buttonNames[i]),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          width: 300,
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 2.5,
            crossAxisCount: 2,
            children: getButtonsList(),
          ),
        ),
        StartButton(
          textStartbutton: "Stop",
          onTapButton: () => widget.buttonLogic('Stop'),
        ),
      ],
    );
  }
}
