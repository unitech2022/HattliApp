import 'package:flutter/material.dart';

//** */ fade opisty
class FadTransition extends PageRouteBuilder {
  final page;
  FadTransition({this.page})
      : super(
            pageBuilder: (context, animation, animationTwq) => page,
            transitionsBuilder: (context, animation, animationTwq, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            });
}

//** */ SlideTransitionPage

// (1 , 0) right to left
// (-1 ,0) left to right
// (0,1 ) bottom to top
//(0, -1)  top  to bottom
class SlideTransitionPage extends PageRouteBuilder {
  final page;
  final double dx, yx;
  SlideTransitionPage({required this.dx, required this.yx, this.page})
      : super(
            pageBuilder: (context, animation, animationTwq) => page,
            transitionsBuilder: (context, animation, animationTwq, child) {
              var begin = Offset(dx, yx);
              var end = Offset(0, 0);
              var tween = Tween(begin: begin, end: end);
              var ofsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: ofsetAnimation,
                child: child,
              );
            });
}

class SizeTransitionPage extends PageRouteBuilder {
  final page;
 
  SizeTransitionPage({this.page})
      : super(
            pageBuilder: (context, animation, animationTwq) => page,
            transitionsBuilder: (context, animation, animationTwq, child) {
              // var begin = Offset(dx, yx);
              // var end = Offset(0, 0);
              // var tween = Tween(begin: begin, end: end);
              // var ofsetAnimation = animation.drive(tween);
              return Align(
                alignment: Alignment.center,
                child: SizeTransition(
                  sizeFactor: animation,
                  child: child,
                ),
              );
            });
}

pushTranslationPage({context, transtion}) {
  Navigator.of(context).push(transtion);
}

pushReplaceTranslationPage({context, transtion}) {
  Navigator.of(context).pushReplacement(transtion);
}
