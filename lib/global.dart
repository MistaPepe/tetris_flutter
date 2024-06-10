
import 'package:riverpod_annotation/riverpod_annotation.dart';

class Player{

  static bool inGame = false;
  static int score = 0;

}

final playerProvider = Provider((ref){
  return Player;
});