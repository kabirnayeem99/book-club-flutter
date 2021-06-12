import 'package:book_club_flutter/utils/Resources.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CurrentUserState extends ChangeNotifier {
  late String _uid;
  late String _email;

  String get getUid => _uid;

  String get getEmail => _email;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<OurResource> signUpUserWithEmail(String email, String password) async {
    late OurResource _resource;
    try {
      UserCredential _userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (_userCredential.user != null) {
        _resource = OurSuccess(_userCredential.user);
        _uid = _userCredential.user!.uid;
        _email = _userCredential.user!.email!;
      } else {
        _resource = OurError("Unknown error");
      }
    } catch (e) {
      _resource = OurError(e.toString());
    }
    return _resource;
  }

  Future<OurResource> loginUserWithEmail(String email, String password) async {
    late OurResource _resource;

    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (_userCredential.user != null) {
        _resource = OurSuccess(_userCredential.user!);
        _uid = _userCredential.user!.uid;
        _email = _userCredential.user!.email!;
      } else {
        _resource = OurError("Unknown error");
      }
    } catch (e) {
      _resource = OurError(e.toString());
      print(e);
    }
    return _resource;
  }
}
