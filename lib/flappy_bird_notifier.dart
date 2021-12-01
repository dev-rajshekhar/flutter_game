import 'package:flutter/foundation.dart';

class FlappyBirdNotifier extends ChangeNotifier {
  int _score = 0;
  int get score => _score;

  double _heightOfPipe = 60;
  double get heightOfPipe => _heightOfPipe;

  void incrementScore() {
    _score++;
    notifyListeners();
  }

  void resetScore() {
    _score = 0;
    notifyListeners();
  }

  // Start the game
  void startGame() {
    notifyListeners();
  }
}
