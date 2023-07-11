import 'package:flutter/widgets.dart';

BoxDecoration decoration (double radius,{color,})=> 
  BoxDecoration(
    color:color,
    borderRadius: BorderRadius.circular(radius),
    boxShadow: const [
      BoxShadow(
        color: Color(0x29b6b6b6),
        offset: Offset(0, 0),
        blurRadius: 10,
      ),
    ],
  );

