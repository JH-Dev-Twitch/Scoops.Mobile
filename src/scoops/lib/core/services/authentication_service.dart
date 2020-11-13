import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    var creds = await _auth.signInWithCredential(credential);
    var appUser = mapUser(creds.user);
    userController.add(appUser);
    return appUser != null;
  }

  AppUser getCurrentUser() {
    var appUser = mapUser(_auth.currentUser);
    userController.add(appUser);
    return appUser;
  }

  Future<bool> logOutAsync() async {
    await _auth.signOut();
    return true;
  }

  AppUser mapUser(User creds) {
    return creds != null
        ? AppUser(
            id: creds.uid,
            username: creds.displayName,
            imageUrl: creds.photoURL)
        : AppUser.unauthorizedUser();
  }
}
