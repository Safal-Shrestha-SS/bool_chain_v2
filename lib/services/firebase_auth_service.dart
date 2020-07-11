import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthService extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;
  LoggedInUser loggedInUser;
  Future<bool> signIN({var email, var password}) async {
    bool check;
    try {
      final user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        loggedInUser = LoggedInUser(loggedInUser: user);
        check = true;
      }
    } catch (e) {
      print(e);
      check = false;
    }
    return check;
  }

  void signOut() {
    _firebaseAuth.signOut();
    loggedInUser = null;
  }
}

class LoggedInUser {
  final loggedInUser;
  LoggedInUser({this.loggedInUser});
}
