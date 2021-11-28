import 'package:flutter/material.dart';

class Hurdle extends StatelessWidget {
  final double height;

  const Hurdle({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: height,
      decoration: BoxDecoration(
        color: Colors.green.shade500,
      ),
    );
  }
}
