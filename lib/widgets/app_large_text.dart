import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLargeText extends StatelessWidget {
  double textSize;
  final String text;
  final Color color;
  AppLargeText({Key? key,
    required this.text,
    this.textSize = 30,
    this.color = Colors.black}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: textSize,
        fontWeight: FontWeight.bold
      ),
    );
  }
}
