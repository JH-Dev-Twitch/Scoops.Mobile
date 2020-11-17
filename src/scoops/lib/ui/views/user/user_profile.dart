import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoops/core/data/models/user.dart';
import 'package:scoops/core/viewModels/user_profile_model.dart';
import 'package:scoops/ui/styling/app_style.dart';
import 'package:scoops/ui/views/base_view.dart';
import 'package:scoops/ui/views/login/login.dart';
import 'package:scoops/ui/widgets/common/custom_switch.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<UserProfileModel>(
        builder: (context, model, child) => Scaffold(
              body: Scaffold(
                backgroundColor: AppStyles.primaryTheme.primaryColor,
                body: SafeArea(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    child,
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: buildUserDetails(context),
                    ),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            buildActionButton(
                                'App Settings',
                                Icons.settings_rounded,
                                Colors.blue[600],
                                Colors.blue[50],
                                null),
                            buildActionButton(
                                'Preferences',
                                Icons.bookmark_border_rounded,
                                Colors.purple[600],
                                Colors.purple[50],
                                null),
                            buildActionButton('Ratings', Icons.star_rounded,
                                Colors.yellow[600], Colors.yellow[50], null),
                            Spacer(),
                            buildActionButton('Sign Out', Icons.logout,
                                Colors.red, Colors.red[100], () async {
                              if (await model.logOutAsync()) {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return LoginView();
                                }));
                              }
                            })
                          ],
                        ),
                      ),
                    ))
                  ],
                )),
              ),
            ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Stack(
            children: [
              GestureDetector(
                child: const Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                ),
                onTap: () => Navigator.pop(context),
              ),
              Center(
                child: const Text(
                  'Profile',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: AnimatedIconSwitch(
                  value: true,
                  textOn: 'Light',
                  textOff: 'Dark',
                  colorOn: Colors.blueGrey,
                  colorOff: Colors.blueGrey,
                  textSize: 14,
                  animationDuration: Duration(milliseconds: 500),
                  onChanged: (bool state) => null,
                ),
              )
            ],
          ),
        ));
  }

  Widget buildUserDetails(BuildContext context) {
    var user = Provider.of<AppUser>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
      child: Center(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Hero(
              tag: 'user_image',
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.imageUrl),
              ),
            ),
          ),
          Text(
            user.username,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          )
        ]),
      ),
    );
  }

  Widget buildActionButton(String text, IconData icon, Color iconColor,
          Color iconBackgroundColor, Function tapped) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: iconBackgroundColor),
              child: Icon(
                icon,
                color: iconColor,
              ),
              padding: EdgeInsets.all(15),
            ),
            Center(
                child: Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
            Icon(Icons.chevron_right_rounded, color: Colors.black, size: 30)
          ],
        ),
      );
}
