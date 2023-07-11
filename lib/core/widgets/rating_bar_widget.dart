import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hatlli/core/layout/palette.dart';

class RatingBarWidget extends StatelessWidget {
 final  double rate;
  const RatingBarWidget({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: rate,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Palette.mainColor,
        size: 10,
      ),
      itemSize: 12,
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
