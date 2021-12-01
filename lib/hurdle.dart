import 'dart:math';

import 'package:flutter/material.dart';

class Hurdle extends StatelessWidget {
  const Hurdle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<double> hurdleHeight = [40.0, 120.0, 60.0, 200.0];

    double getHurdleHeight() {
      return hurdleHeight[Random().nextInt(hurdleHeight.length)];
    }

    return Container(
      width: 40,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.green.shade500,
      ),
    );
  }
}
