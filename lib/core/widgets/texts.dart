import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Texts extends StatelessWidget {
  final String title, family;
  final double size;
  final Color textColor;
  final FontWeight widget;
  final double height;
  final int line;

  const Texts({
    super.key,
    required this.title,
    required this.family,
    required this.size,
    this.textColor = Colors.black,
    this.height = 1.05,
    this.widget = FontWeight.normal,
    this.line=1
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: line,
      style: TextStyle(
        fontFamily: family,
        fontSize: size,
        color: textColor,
        fontWeight: widget,
        height: height,
      ),
      textHeightBehavior:
          const TextHeightBehavior(applyHeightToFirstAscent: false),
    );
  }
}
