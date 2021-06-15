import 'package:book_club_flutter/screens/root_screen/root_screen.dart';
import 'package:book_club_flutter/states/current_user.dart';
import 'package:book_club_flutter/utils/resource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OurHomeScreen extends StatelessWidget {
  const OurHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book Club")),
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            CurrentUserState _userState =
                Provider.of<CurrentUserState>(context, listen: false);
            OurResource _resource = await _userState.signOut();

            if (_resource is OurSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => OurRootScreen()),
                (route) => false,
              );
            } else {
              debugPrint(_resource.errorMessage);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text("Could not sign out. ${_resource.errorMessage!}"),
                ),
              );
            }
          },
          child: Text("Sign Out"),
        ),
      ),
    );
  }
}
