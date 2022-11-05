import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {
  const BoldText({super.key, required this.text, this.color = Colors.white});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, color: color, shadows: [
        Shadow(
          offset: const Offset(2.0, 2.0),
          blurRadius: 6.0,
          color: Colors.black.withOpacity(0.8),
        ),
      ]),
    );
  }
}
