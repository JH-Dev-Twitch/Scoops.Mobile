import 'package:flutter/material.dart';

class ActionsWidget extends StatelessWidget {
  const ActionsWidget({Key key, this.avatarUrl}) : super(key: key);
  final String avatarUrl;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CircleAvatar(
        backgroundImage: NetworkImage(avatarUrl),
        maxRadius: 15,
      ),
      SizedBox(
        width: 10,
      ),
      Icon(
        Icons.map,
        size: 25,
        color: Colors.white,
      ),
      SizedBox(
        width: 10,
      ),
      Icon(
        Icons.search,
        size: 25,
        color: Colors.white,
      )
    ]);
  }
}
