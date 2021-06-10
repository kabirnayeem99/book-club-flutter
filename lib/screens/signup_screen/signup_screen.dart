import 'package:flutter/material.dart';
import 'local_widgets/signup_form_widget.dart';

class OurSignupScreen extends StatelessWidget {
  const OurSignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(20, 28 , 20, 20),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BackButton(),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                OurSignupFormWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
