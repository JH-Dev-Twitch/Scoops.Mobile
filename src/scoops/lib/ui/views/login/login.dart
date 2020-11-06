import 'package:flutter/material.dart';
import 'package:scoops/core/enums/view_state.dart';
import 'package:scoops/core/viewModels/login_model.dart';
import 'package:scoops/ui/views/base_view.dart';
import 'package:scoops/ui/views/home.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
        builder: (context, model, child) => Scaffold(
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        model.state == ViewState.Loading
                            ? buildLoadingUI(context)
                            : buildLoginUI(context, model),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }

  CircularProgressIndicator buildLoadingUI(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: Theme.of(context).accentColor,
    );
  }

  Widget buildLoginUI(BuildContext context, LoginModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FlatButton.icon(
            icon: Icon(Icons.login),
            minWidth: 200,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: () async {
              var loggedIn = await model.login();
              if (loggedIn)
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return ScoopsHomePage();
                }));
            },
            label: Text('Login')),
      ],
    );
  }
}
