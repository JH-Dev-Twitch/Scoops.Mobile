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
                            ? CircularProgressIndicator(
                                backgroundColor: Colors.lightBlue,
                              )
                            : FlatButton(
                                color: Colors.blue,
                                textColor: Colors.white,
                                onPressed: () async {
                                  var loggedIn = await model.login();
                                  if (loggedIn)
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ScoopsHomePage();
                                    }));
                                },
                                child: Text('Login')),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}
