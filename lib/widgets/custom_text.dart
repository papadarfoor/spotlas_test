import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text, this.color = Colors.white});

  final String text;
  final Color color;
  

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:  TextStyle(
        fontWeight: FontWeight.w400,
        color: color,
       shadows: [ 
          Shadow(
            offset: const Offset(2.0, 2.0),
            color: Colors.black.withOpacity(0.8), 
          ),


      ]
      ),
       overflow: TextOverflow.ellipsis,
       maxLines: 2,
    );
  }
}
