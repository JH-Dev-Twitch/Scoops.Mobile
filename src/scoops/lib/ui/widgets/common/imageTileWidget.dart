import 'dart:ui';

import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  const ImageTile({Key key, this.imageUrl, this.text}) : super(key: key);
  final String imageUrl;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Stack(
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.fitWidth,
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
              child: Align(
                alignment: Alignment.center,
                child: Center(
                    child: Text(
                  text,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
