import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scoops/core/enums/view_state.dart';
import 'package:scoops/core/viewModels/login_model.dart';
import 'package:scoops/ui/styling/app_style.dart';
import 'package:scoops/ui/views/base_view.dart';
import 'package:scoops/ui/views/home.dart';
import 'package:scoops/ui/views/rnd/rnd_home.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
        builder: (context, model, child) => Scaffold(
              backgroundColor: AppStyles.primaryTheme.primaryColor,
              body: SafeArea(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      model.state == ViewState.Ready
                          ? buildLoginUI(context, model)
                          : buildLoadingUI(context),
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget buildLoadingUI(BuildContext context) {
    return Column(
      children: [
        Lottie.asset(
          "assets/animations/drinks.json",
          width: 300,
          height: 300,
          fit: BoxFit.fitHeight,
        ),
        Text(
          'Logging in...',
          style: const TextStyle(color: Colors.white, fontSize: 20),
        )
      ],
    );
  }

  Widget buildLoginUI(BuildContext context, LoginModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Scoops', style: TextStyle(color: Colors.white, fontSize: 40)),
            Padding(
                padding: const EdgeInsets.all(20),
                child: Lottie.asset(
                  "assets/animations/drinks.json",
                  width: 300,
                  height: 300,
                  fit: BoxFit.fitHeight,
                )),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RaisedButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)),
                padding: const EdgeInsets.all(10),
                elevation: 2,
                onPressed: () async {
                  var loggedIn = await model.login();
                  if (loggedIn)
                    //naviagtionservice.navigate(home);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return ScoopsHomePage();
                    }));
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1004px-Google_%22G%22_Logo.svg.png',
                        fit: BoxFit.fitWidth,
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Continue with Google',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                      )
                    ])),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: FlatButton.icon(
                  icon: Icon(Icons.handyman),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return RnDHomeView();
                    }));
                  },
                  label: Text('RnD')),
            ),
          ],
        ),
      ],
    );
  }
}
