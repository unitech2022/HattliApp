import 'package:flutter/cupertino.dart';

class Texts extends StatelessWidget {
  final String title, family;
  final double size;
  final Color textColor;
  final FontWeight widget;

  const Texts({super.key, required this.title, required this.family, required this.size, required this.textColor, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: family,
        fontSize: size,
        color: textColor,
        fontWeight:widget,
        height: 1.05,
      ),
      textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
      softWrap: false,
    );
  }
}
