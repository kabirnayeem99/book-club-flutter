import 'package:book_club_flutter/screens/no_group_screen/no_group_screen.dart';
import 'package:book_club_flutter/screens/root_screen/root_screen.dart';
import 'package:book_club_flutter/states/current_user.dart';
import 'package:book_club_flutter/utils/resource.dart';
import 'package:book_club_flutter/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OurHomeScreen extends StatelessWidget {
  const OurHomeScreen({Key? key}) : super(key: key);

  void _signOut(BuildContext context) async {
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
          content: Text(
              "Could not sign out. ${_resource.errorMessage ?? "Unknown error."}"),
        ),
      );
    }
  }

  void _goToNoGroup(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OurNoGroupScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OurContainerWidget(
              child: Column(
                children: [
                  Container(
                    width: 300.0,
                    child: Row(
                      children: [
                        Container(
                          child: Image.network(
                              "http://www.lightbookstore.com.au/wp-content/uploads/2014/08/fiqh_akbar-200x300.jpg"),
                          height: 120.0,
                          width: 80.0,
                          padding: EdgeInsets.all(8.0),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Fiqh al-Akbar",
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.grey[600],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 22.0, horizontal: 0.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Due in: ",
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    "8 days",
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 300.0,
                    child: RaisedButton(
                      onPressed: () => {},
                      child: Text(
                        "Finished Book",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OurContainerWidget(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      "Next book revealed in:",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      "22 Hours",
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 20.0,
            ),
            child: RaisedButton(
              onPressed: () => _goToNoGroup(context),
              child: Text("Book Club History"),
              color: Theme.of(context).canvasColor,
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).secondaryHeaderColor,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: RaisedButton(
              onPressed: () => _signOut(context),
              child: Text("Sign Out"),
            ),
          ),
        ],
      ),
    );
  }
}
