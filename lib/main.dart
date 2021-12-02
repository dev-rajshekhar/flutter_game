import 'package:flutter/material.dart';
import 'package:flutter_game/flappy_bird.dart';
import 'package:flutter_game/paint_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  static var gameList = ["Flappy Bird", "Paint"];
  const MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Game'),
        ),
        body: ListView.builder(
            itemCount: gameList.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  title: Text(gameList[index]),
                  onTap: () {
                    var widget = gameList[index] == "Flappy Bird"
                        ? const FlappyBirdGame()
                        : const PaintGame();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return widget;
                        },
                      ),
                    );
                  },
                ),
              );
            }));
  }
}
