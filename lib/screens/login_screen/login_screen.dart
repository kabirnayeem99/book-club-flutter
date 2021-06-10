import 'package:book_club_flutter/screens/login_screen/local_widgets/login_form_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OurLoginScreen extends StatelessWidget {
  const OurLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: [
                Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Image.asset("assets/logo.png"),
                ),
                SizedBox(height: 20.0),
                OurLoginForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
