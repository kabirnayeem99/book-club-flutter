import 'package:book_club_flutter/utils/resource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CurrentUserState extends ChangeNotifier {
  late String _uid;
  late String _email;

  String get getUid => _uid;

  String get getEmail => _email;

  FirebaseAuth _auth = FirebaseAuth.instance;

  /// Registers the user with email and passwords
  ///
  /// Takes 'email' and 'password' as parameters
  ///
  /// Returns a Future OurResource class, which can be either OurSuccess
  /// with the returned data
  /// or can be OurError with a String Error message.
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

  /// Logs in the user with email and password
  /// Takes 'email' and 'password' as parameter
  ///
  /// Returns a Future OurResource class,
  ///
  /// which can be either OurSuccess
  /// with the returned data
  /// or can be OurError with a String Error message.
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
    }
    return _resource;
  }

  /// Signs in the user with existing Google Account
  /// Takes no parameter
  /// Returns a Future OurResource class, which can be either OurSuccess
  /// with the returned data
  /// or can be OurError with a String Error message.
  Future<OurResource> logInUserWithGoogle() async {
    late OurResource _resource;

    try {
      GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );

      GoogleSignInAccount? _googleAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication? _googleAuth =
          await _googleAccount?.authentication;

      if (_googleAuth != null) {
        OAuthCredential _oAuthCred = GoogleAuthProvider.credential(
          idToken: _googleAuth.idToken,
          accessToken: _googleAuth.accessToken,
        );

        UserCredential _userCred = await _auth.signInWithCredential(_oAuthCred);

        if (_userCred.user == null) {
          _resource = OurError("Null user");
        } else {
          if (_googleSignIn.currentUser?.email != null) {
            _email = _userCred.user!.email!;
            _uid = _userCred.user!.uid;
            _resource = OurSuccess(_userCred.user);
          }
        }
      } else {
        _resource = OurError("Could not sign in with Google.");
      }
    } catch (e) {
      _resource = OurError(e.toString());
    }
    return _resource;
  }
}
