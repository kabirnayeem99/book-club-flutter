import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CurrentUserState extends ChangeNotifier {
  late String _uid;
  late String _email;

  String get getUid => _uid;

  String get getEmail => _email;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signUpUser(String email, String password) async {
    bool isSignedUp = false;
    try {
      UserCredential _userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (_userCredential.user != null) {
        isSignedUp = true;
        _uid = _userCredential.user!.uid;
        _email = _userCredential.user!.email!;
      } else {
        isSignedUp = false;
      }
    } catch (e) {
      isSignedUp = false;
      print(e);
    }
    return isSignedUp;
  }

  Future<bool> loginUser(String email, String password) async {
    bool isLoggedIn = false;
    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (_userCredential.user != null) {
        isLoggedIn = true;
        _uid = _userCredential.user!.uid;
        _email = _userCredential.user!.email!;
      } else {
        isLoggedIn = false;
      }
    } catch (e) {
      isLoggedIn = false;
      print(e);
    }
    return isLoggedIn;
  }
}
