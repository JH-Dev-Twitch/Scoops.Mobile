import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

import 'package:scoops/core/data/models/user.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  StreamController<AppUser> userController = new StreamController<AppUser>();
  Future<bool> login() async {
    //Google Login
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential with Google tokens
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    var user = await _auth.signInWithCredential(credential);
    var appUser = MapUser(user);
    userController.add(appUser);
    return appUser != null;
  }

  AppUser MapUser(UserCredential creds) {
    if (creds != null) {
      return AppUser(
          id: creds.user.uid,
          username: creds.user.displayName,
          imageUrl: creds.user.photoURL);
    } else {
      return AppUser.unauthorizedUser();
    }
  }
}
