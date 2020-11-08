import 'package:flutter/material.dart';
import 'package:scoops/ui/views/user/user_profile.dart';

class ActionsWidget extends StatelessWidget {
  const ActionsWidget({Key key, this.avatarUrl}) : super(key: key);
  final String avatarUrl;
  static const double spacing = 15;
  static const SizedBox spacer = SizedBox(
    width: spacing,
  );
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      GestureDetector(
        onTap: () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => UserProfileView())),
        child: CircleAvatar(
          backgroundImage: this.avatarUrl == null
              ? Icon(Icons.supervised_user_circle_rounded)
              : NetworkImage(avatarUrl),
          maxRadius: 15,
        ),
      ),
      spacer,
      Icon(
        Icons.map,
        size: 25,
        color: Colors.white,
      ),
      spacer,
      Icon(
        Icons.search,
        size: 25,
        color: Colors.white,
      )
    ]);
  }
}
