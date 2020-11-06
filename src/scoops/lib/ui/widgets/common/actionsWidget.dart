import 'package:flutter/material.dart';

class ActionsWidget extends StatelessWidget {
  const ActionsWidget({Key key, this.avatarUrl}) : super(key: key);
  final String avatarUrl;
  static const double spacing = 15;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CircleAvatar(
        backgroundImage: this.avatarUrl == null
            ? Icon(Icons.supervised_user_circle_rounded)
            : NetworkImage(avatarUrl),
        maxRadius: 15,
      ),
      const SizedBox(
        width: spacing,
      ),
      Icon(
        Icons.map,
        size: 25,
        color: Colors.white,
      ),
      const SizedBox(
        width: spacing,
      ),
      Icon(
        Icons.search,
        size: 25,
        color: Colors.white,
      )
    ]);
  }
}
