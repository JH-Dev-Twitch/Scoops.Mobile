import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  const Rating({Key key, this.rating, this.reviews}) : super(key: key);
  final double rating;
  final int reviews;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.star,
          color: Colors.yellow[600],
          size: 21,
        ),
        Text(
          ' ${rating > 5.0 ? '5.0' : rating.toString()}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          reviews > 99 ? "  (99+)" : "  ($reviews)",
          style: TextStyle(
            color: Colors.grey[500],
          ),
        )
      ],
    );
  }
}
