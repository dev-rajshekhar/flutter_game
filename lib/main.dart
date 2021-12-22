import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/paint/paint_game.dart';

import 'flappy_bird_game/flappy_bird.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
                    // FirebaseFirestore.instance
                    //     .collection("games")
                    //     .doc(gameList[index])
                    //     .set({
                    //   "name": gameList[index],
                    //   "played": FieldValue.increment(1),
                    // });
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
