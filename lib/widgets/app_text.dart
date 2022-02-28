import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final double textSize;
  final String text;
  final Color color;
  const AppText(
      {Key? key,
      required this.text,
      this.textSize = 16,
      this.color = Colors.black54})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: textSize,
      ),
    );
  }
}
