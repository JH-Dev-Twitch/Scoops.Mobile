import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoops/core/constants/app_constants.dart';
import 'package:scoops/core/data/models/user.dart';
import 'package:scoops/core/viewModels/user_profile_model.dart';
import 'package:scoops/ui/styling/app_style.dart';
import 'package:scoops/ui/views/base_view.dart';
import 'package:scoops/ui/views/login/login.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<UserProfileModel>(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            child,
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(30),
              child: RaisedButton(
                color: AppStyles.primaryTheme.primaryColor,
                onPressed: () async {
                  if (await model.logOutAsync()) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginView();
                    }));
                  }
                },
                child: Text(
                  'Sign Out',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        )),
      ),
      child: buildUserDetails(context),
    );
  }

  Widget buildUserDetails(BuildContext context) {
    var user = Provider.of<AppUser>(context);
    return Center(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(user.imageUrl),
          ),
        ),
        Text(
          user.username,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )
      ]),
    );
  }
}
