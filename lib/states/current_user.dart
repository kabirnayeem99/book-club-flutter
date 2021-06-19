import 'package:book_club_flutter/models/user.dart';
import 'package:book_club_flutter/utils/resource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CurrentUserState extends ChangeNotifier {
  OurUser? _currentUser;

  OurUser? get getCurrentUser => _currentUser;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<OurResource> signOut() async {
    late OurResource _resource;
    try {
      await _auth.signOut();
      _currentUser = null;
      _resource = OurSuccess(_currentUser);
    } catch (e) {
      _resource = OurError(e.toString());
    }
    return _resource;
  }

  /// Checks for current authentication status
  ///
  /// Returns a Future OurResource class, which can be either OurSuccess
  /// with the returned data
  /// or can be OurError with a String Error message.
  Future<OurResource> onStartup() async {
    late OurResource _resource;

    try {
      User? _user = _auth.currentUser;
      if (_user != null) {
        _currentUser = OurUser(email: _user.email!, uid: _user.uid);
        _resource = OurSuccess(_currentUser);
      } else {
        _resource = OurError("User is null");
      }
    } catch (e) {
      _resource = OurError(e.toString());
    }

    return _resource;
  }

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
        _currentUser = OurUser(
          email: _userCredential.user!.email!,
          uid: _userCredential.user!.uid,
        );
        _resource = OurSuccess(_currentUser);
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
        _currentUser = OurUser(
          email: _userCredential.user!.email!,
          uid: _userCredential.user!.uid,
        );
        _resource = OurSuccess(_currentUser);
      } else {
        _resource = OurError("User is null");
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
          _resource = OurError("User is null");
        } else {
          if (_googleSignIn.currentUser?.email != null) {
            _currentUser = OurUser(
                email: _userCred.user!.email!, uid: _userCred.user!.uid);
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
