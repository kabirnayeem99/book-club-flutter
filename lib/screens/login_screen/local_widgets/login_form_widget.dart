import 'package:book_club_flutter/screens/home_screen/home_screen.dart';
import 'package:book_club_flutter/screens/signup_screen/signup_screen.dart';
import 'package:book_club_flutter/states/current_user.dart';
import 'package:book_club_flutter/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OurLoginForm extends StatefulWidget {
  const OurLoginForm({Key? key}) : super(key: key);

  @override
  _OurLoginFormState createState() => _OurLoginFormState();
}

class _OurLoginFormState extends State<OurLoginForm> {
  TextEditingController _emailTec = TextEditingController();
  TextEditingController _passwordTec = TextEditingController();

  void _logInUser(String email, String password, BuildContext context) async {
    CurrentUserState _userState =
        Provider.of<CurrentUserState>(context, listen: false);

    try {
      bool isLoggedIn = await _userState.loginUser(email, password);
      if (isLoggedIn) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OurHomeScreen()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Could not login.")));
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Could not log in. $e.")));
    }
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
                _logInUser(_emailTec.text, _passwordTec.text, context);
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
        ],
      ),
    );
  }
}
