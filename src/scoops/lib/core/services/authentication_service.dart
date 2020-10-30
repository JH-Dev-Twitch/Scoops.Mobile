import 'package:scoops/core/data/models/user.dart';
import 'dart:async';

class AuthenticationService {
  StreamController<User> userController = StreamController<User>();

  Future<bool> login() async {
    return true;
  }
}
