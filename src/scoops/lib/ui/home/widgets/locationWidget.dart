import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({Key key, this.locationName}) : super(key: key);

  final String locationName;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.place,
            size: 15,
            color: Colors.white,
          )),
      Text(
        locationName,
        style: TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
      )
    ]);
  }
}
