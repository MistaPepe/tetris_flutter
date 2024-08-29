import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

//codes for boolean if in game, if player lose, and timer

bool inGame = false;

class GameEnds extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void toggle(value) {
    state = value;
  }
}

final gameEndsProvider = NotifierProvider<GameEnds, bool>(() => GameEnds());

class Score extends Notifier<double> {
  @override
  double build() {
    return 0;
  }

  void reset() {
    state = 0.0;
  }

  void incrementScore(double multiplier, double chainClear) {
    state += (10 * multiplier) + (10 * chainClear) ;
  }
}

final scoreProvider = NotifierProvider<Score, double>(() => Score());

class Timers extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void startCountdown(int setter) {
    state = setter;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      state--;
      if (state == 0) {
        timer.cancel();
      }
    });
  }
}

final timerProvider = NotifierProvider<Timers, int>(() => Timers());
