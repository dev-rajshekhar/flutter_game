import 'package:flutter/material.dart';

class Dash extends StatelessWidget {
  const Dash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/dash.png",
      height: 100,
      width: 100,
    );
  }
}
