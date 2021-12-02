import 'package:flutter/material.dart';

class Hurdle extends StatelessWidget {
  const Hurdle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.green.shade500,
      ),
    );
  }
}
