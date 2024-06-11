
import 'package:tetris_flutter/provider/grid_block_provider.dart';


class GameButtonLogic extends Grid{

  final String pressedButton;

  GameButtonLogic(this.pressedButton);


  function(){
    switch(pressedButton){
      case 'Shift':
      print(blockLayout);
      break;
      case 'Switch':
print(blockLayout);
      break;
      case 'Left':
print(blockLayout);
      break;
      case 'Right':
print(blockLayout);
      break;
      case 'Down':
print(blockLayout);
      break;
      case 'Drop':
print(blockLayout);
      break;
    }
  }
}