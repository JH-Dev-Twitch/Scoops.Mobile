import 'package:flutter/material.dart';

class EstablishmentCard extends StatelessWidget {
  const EstablishmentCard({Key key, this.imageUrl, this.text})
      : super(key: key);
  final String imageUrl;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Stack(
          children: [Image.network(imageUrl), Center(child: Text(text))],
        ),
      ),
    );
  }
}
