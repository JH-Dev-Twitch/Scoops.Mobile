import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scoops/core/data/models/user.dart';
import 'dart:async';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  StreamController<AppUser> userController = StreamController<AppUser>();

  Future<bool> login() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    var user = await _auth.signInWithCredential(credential);
    return user != null;
  }
}
