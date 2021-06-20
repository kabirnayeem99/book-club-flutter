import 'package:book_club_flutter/screens/home_screen/home_screen.dart';
import 'package:book_club_flutter/screens/root_screen/root_screen.dart';
import 'package:book_club_flutter/screens/signup_screen/signup_screen.dart';
import 'package:book_club_flutter/states/current_user.dart';
import 'package:book_club_flutter/utils/resource.dart';
import 'package:book_club_flutter/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Form Widget for Login screen
class OurLoginForm extends StatefulWidget {
  const OurLoginForm({Key? key}) : super(key: key);

  @override
  _OurLoginFormState createState() => _OurLoginFormState();
}

class _OurLoginFormState extends State<OurLoginForm> {
  TextEditingController _emailTec = TextEditingController();
  TextEditingController _passwordTec = TextEditingController();

  void _logInUserWithEmail(
      String email, String password, BuildContext context) async {
    CurrentUserState _userState =
        Provider.of<CurrentUserState>(context, listen: false);

    try {
      OurResource _logInResource =
          await _userState.loginUserWithEmail(email, password);
      if (_logInResource is OurSuccess) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => OurRootScreen()),
          (route) => false,
        );
      } else {
        print(_logInResource.errorMessage);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_logInResource.errorMessage!),
          ),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Could not log in. $e.")));
    }
  }

  void _logInUserWithGoogle(BuildContext context) async {
    CurrentUserState _userState =
        Provider.of<CurrentUserState>(context, listen: false);

    try {
      OurResource _logInResource = await _userState.logInUserWithGoogle();
      if (_logInResource is OurSuccess) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OurHomeScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_logInResource.errorMessage!),
          ),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Could not log in. $e.")));
    }
  }

  Widget _googleSignInButton(BuildContext context) {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        _logInUserWithGoogle(context);
      },
      highlightElevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("assets/google_logo.png"),
            height: 25.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              "Sign in with google.",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OurContainerWidget(
      child: Column(
        children: [
          // login title
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
            child: Text(
              "Login",
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // email text form field
          TextFormField(
            controller: _emailTec,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.alternate_email_rounded,
              ),
              hintText: "Email",
            ),
          ),
          SizedBox(height: 20.0),

          // password text form field
          TextFormField(
            controller: _passwordTec,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_outline_rounded),
              hintText: "Password",
            ),
          ),
          SizedBox(height: 20.0),

          // login button
          RaisedButton(
            onPressed: () {
              if (_emailTec.text.trim().isNotEmpty &&
                  _passwordTec.text.trim().isNotEmpty) {
                _logInUserWithEmail(_emailTec.text, _passwordTec.text, context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Text fields can't be empty")));
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          SizedBox(height: 08.0),
          // register navigation button
          FlatButton(
            onPressed: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OurSignupScreen(),
                ),
              ),
            },
            child: Text("Don't have an account? Sign up here."),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),

          // google sign in button
          SizedBox(height: 20.0),
          _googleSignInButton(context),
        ],
      ),
    );
  }
}
