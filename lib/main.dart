import 'package:flutter/material.dart';
import 'package:flutter_game/flappy_bird.dart';

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
      home: const FlappyBirdGame(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Game'),
        ),
        body: ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  title: const Text('Flappy Bird'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const FlappyBirdGame();
                    }));
                  },
                ),
              );
            }));
  }
}
