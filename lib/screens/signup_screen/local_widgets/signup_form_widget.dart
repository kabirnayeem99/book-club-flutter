import 'package:book_club_flutter/states/current_user.dart';
import 'package:book_club_flutter/utils/resource.dart';
import 'package:book_club_flutter/widgets/container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OurSignupFormWidget extends StatefulWidget {
  const OurSignupFormWidget({Key? key}) : super(key: key);

  @override
  _OurSignupFormWidgetState createState() => _OurSignupFormWidgetState();
}

class _OurSignupFormWidgetState extends State<OurSignupFormWidget> {
  TextEditingController _emailTec = TextEditingController();
  TextEditingController _fullNameTec = TextEditingController();
  TextEditingController _passwordTec = TextEditingController();
  TextEditingController _confirmPasswordTec = TextEditingController();

  @override
  void dispose() {
    _emailTec.dispose();
    _fullNameTec.dispose();
    _passwordTec.dispose();
    _confirmPasswordTec.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _signUpUser(String email, String password, String fullName,
        BuildContext context) async {
      CurrentUserState _currentUserState =
          Provider.of<CurrentUserState>(context, listen: false);

      try {
        OurResource _signUpResource = await _currentUserState
            .signUpUserWithEmail(email, password, fullName);

        if (_signUpResource is OurSuccess) {
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(_signUpResource.errorMessage!)));
        }
      } catch (e) {
        print("could not sign up" + e.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Could not register $e.")));
      }
    }

    return OurContainerWidget(
      child: Column(
        children: [
          // sign up title
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
            child: Text(
              "Sign up",
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // email field
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

          // full name field
          TextFormField(
            controller: _fullNameTec,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person_outline_rounded),
              hintText: "Full Name",
            ),
          ),
          SizedBox(height: 20.0),

          // password field
          TextFormField(
            controller: _passwordTec,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_outline_rounded),
              hintText: "Password",
            ),
          ),
          SizedBox(height: 20.0),

          // confirm password field
          TextFormField(
            controller: _confirmPasswordTec,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_open_rounded),
              hintText: "Confirm Password",
            ),
          ),
          SizedBox(height: 20.0),

          // sign up button
          RaisedButton(
            onPressed: () {
              if (_passwordTec.text == _confirmPasswordTec.text) {
                _signUpUser(
                  _emailTec.text.toString(),
                  _passwordTec.text.toString(),
                  _fullNameTec.text.toString(),
                  context,
                );
                debugPrint("email: ${_emailTec.text.toString()},\n "
                    "password: ${_passwordTec.text.toString()}, \n"
                    "full name: ${_fullNameTec.text.toString()},  \n");
              } else {
                final snackBar =
                    SnackBar(content: Text("Password doesn't match."));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                _confirmPasswordTec.clear();
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                "Sign up",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
