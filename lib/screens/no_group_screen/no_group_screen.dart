import 'package:flutter/material.dart';

class OurNoGroupScreen extends StatelessWidget {
  void _goToJoin() {}

  void _goToCreate() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Spacer(flex: 2),
          Padding(
            padding: const EdgeInsets.all(48.0),
            child: Image.asset("assets/logo.png"),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 30.0, right: 30.0, top: 15.0, bottom: 12.0),
            child: Text(
              "Welcome to Book Club",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 52.0),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 30.0, left: 30.0, right: 30.0),
            child: Text(
              "Since, you are not currently joined in a book club right now. You need to join to one or create a new one. ",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Spacer(flex: 1),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlatButton(
                  onPressed: () => _goToCreate(),
                  child: Text("Create"),
                  color: Theme.of(context).canvasColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(
                      color: Theme.of(context).secondaryHeaderColor,
                      width: 2.0,
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: () => _goToJoin(),
                  child: Text(
                    "Join",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
