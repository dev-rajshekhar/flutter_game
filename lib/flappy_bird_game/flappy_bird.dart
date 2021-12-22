import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_game/flappy_bird_game/dash.dart';
import 'package:flutter_game/hurdle.dart';

class FlappyBirdGame extends StatefulWidget {
  const FlappyBirdGame({Key? key}) : super(key: key);

  @override
  State<FlappyBirdGame> createState() => _FlappyBirdGameState();
}

class _FlappyBirdGameState extends State<FlappyBirdGame> {
  static double dashYAxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = dashYAxis;
  bool isGameStarted = false;
  static double barrierXOne = 2.5;
  double barrierXTwo = barrierXOne + 1.75;
  int score = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        debugPrint('TAP $isGameStarted  $dashYAxis');
        if (isGameStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                AnimatedContainer(
                    color: Colors.blue,
                    alignment: Alignment(0, dashYAxis),
                    duration: const Duration(seconds: 0),
                    child: const Dash()),
                Container(
                  alignment: const Alignment(0, 0.5),
                  child: !isGameStarted
                      ? const Text(
                          'T A P  T O  S T A R T',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                // AnimatedContainer(
                //   duration: const Duration(milliseconds: 0),
                //   alignment: Alignment(barrierXOne, -1),
                //   child: Hurdle(),
                // ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 0),
                  alignment: Alignment(barrierXOne, 1),
                  child: Hurdle(),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 0),
                  alignment: Alignment(barrierXTwo, -1),
                  child: Hurdle(),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 0),
                  alignment: Alignment(barrierXTwo, 1),
                  child: Hurdle(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
            child: Container(color: Colors.green),
          ),
          Expanded(
            child: Container(
              color: Colors.brown,
              child: Row(children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("$score"),
                      Text("S C O R E"),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("0"),
                      Text(" B E S T  S C O R E"),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    ));
  }

  bool checkIsGameOver() {
    return dashYAxis > 1;
  }

  void resetGame() {
    setState(() {
      isGameStarted = false;
      dashYAxis = 0;
      time = 0;
      height = 0;
      initialHeight = dashYAxis;
      barrierXOne = 2.5;
      barrierXTwo = barrierXOne + 1.75;
      score = 0;
    });
  }

  void startGame() {
    initialHeight = dashYAxis;
    isGameStarted = true;
    Timer.periodic(
      const Duration(milliseconds: 60),
      (timer) {
        time += 0.05;
        height = -4.9 * time * time + 2.8 * time;
        setState(
          () {
            score = score + 1;
            barrierXOne -= 0.05;
            barrierXTwo -= 0.05;
            if (barrierXOne > 2) {
              barrierXOne -= 3.5;
            } else {
              barrierXOne += 0.04;
            }
            if (barrierXTwo > 2) {
              barrierXTwo -= 3.5;
            } else {
              barrierXTwo += 0.04;
            }
            dashYAxis = initialHeight - height;
          },
        );
        if (checkIsGameOver()) {
          timer.cancel();
          isGameStarted = false;
          showGameOver();
        }
        if (barrierXOne > 2) {
          barrierXOne -= 3.5;
        } else {
          barrierXOne += 0.04;
        }
        if (barrierXTwo > 2) {
          barrierXTwo -= 3.5;
        } else {
          barrierXTwo += 0.04;
        }
        // if (barrierXOne >= -0.25 && barrierXOne <= 0.25) {
        //   if (dashYAxis <= -0.2 || dashYAxis >= 0.6) {
        //     timer.cancel();
        //     // scoreTimer.cancel();
        //     isGameStarted = false;
        //     // if (score > highScore) {
        //     //   highScore = score;
        //     //   await prefs.setInt(HIGH_SCORE_KEY, highScore);
        //     // }
        //     setState(() {});
        //     // await showLoseDialog();
        //   }
        // }
        // if (barrierXTwo >= -0.25 && barrierXTwo <= 0.25) {
        //   if (dashYAxis <= -0.6 || dashYAxis >= 0.2) {
        //     timer.cancel();
        //     // scoreTimer.cancel();
        //     isGameStarted = false;
        //     // if (score > highScore) {
        //     //   highScore = score;
        //     // }
        //     setState(() {});
        //     // showLoseDialog();
        //   }
        // }

        if (dashYAxis > 1) {
          timer.cancel();
          isGameStarted = false;
        }
      },
    );
  }

  void showGameOver() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text('Your Score is $score'),
          actions: <Widget>[
            MaterialButton(
              child: const Text('Restart'),
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
            ),
          ],
        );
      },
    );
  }

  void jump() {
    setState(() {
      time = 0;
      initialHeight = dashYAxis;
    });
  }
}
