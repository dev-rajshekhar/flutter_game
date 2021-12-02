import 'package:flutter/material.dart';

class PaintGame extends StatefulWidget {
  const PaintGame({Key? key}) : super(key: key);

  @override
  _PaintGameState createState() => _PaintGameState();
}

class _PaintGameState extends State<PaintGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paint Game'),
      ),
    );
  }
}
