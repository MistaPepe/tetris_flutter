import 'package:flutter_riverpod/flutter_riverpod.dart';

class Player{

  static bool inGame = false;
  static int score = 0;

}

final playerProvider = Provider((ref){
  return Player;
});