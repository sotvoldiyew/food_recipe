
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyRating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: RatingBar.builder(
        itemSize: 30,
        initialRating: 3,
        minRating: 1,
        direction: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {},
      ),
    );
  }
}
