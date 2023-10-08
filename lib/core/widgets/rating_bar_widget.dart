import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hatlli/core/layout/palette.dart';

class RatingBarWidget extends StatelessWidget {
 final  double rate ,size;
  const RatingBarWidget({super.key, required this.rate,this.size=10});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: rate,
      minRating: 1,
       ignoreGestures: true,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
      itemBuilder: (context, _) =>  Icon(
        Icons.star,
        color: Palette.mainColor,
        size: size,
      ),
      itemSize: size, onRatingUpdate: (double value) {  },
      // onRatingUpdate: (rating) {
      //   print(rating);
      // },
    );
  }
}
