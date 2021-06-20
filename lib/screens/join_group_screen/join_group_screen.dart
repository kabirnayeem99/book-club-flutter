import 'package:book_club_flutter/screens/home_screen/home_screen.dart';
import 'package:book_club_flutter/screens/root_screen/root_screen.dart';
import 'package:book_club_flutter/services/db.dart';
import 'package:book_club_flutter/states/current_user.dart';
import 'package:book_club_flutter/utils/resource.dart';
import 'package:book_club_flutter/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OurJoinGroupScreen extends StatelessWidget {
  final TextEditingController _groupIdTec = TextEditingController();

  void _joinGroup(BuildContext context, String groupId) async {
    OurDatabase _db = OurDatabase();

    CurrentUserState _userState =
        Provider.of<CurrentUserState>(context, listen: false);

    if (_userState.getCurrentUser.uid != null) {
      OurResource _createGroupRes =
          await _db.joinGroup(groupId, _userState.getCurrentUser.uid!);
      if (_createGroupRes is OurSuccess) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => OurHomeScreen()),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Could not create the group. ${_createGroupRes.errorMessage ?? "Unknown error."}"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Row(
              children: [
                SizedBox(height: 12.0),
                BackButton(),
                Spacer(flex: 1),
              ],
            ),
            Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: OurContainerWidget(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _groupIdTec,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.group),
                          hintText: "Group id",
                        ),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    RaisedButton(
                      onPressed: () => _joinGroup(context, _groupIdTec.text),
                      child: Text(
                        "Join Group",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
