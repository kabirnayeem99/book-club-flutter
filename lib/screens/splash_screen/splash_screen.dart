import 'package:flutter/material.dart';

class OurSplashScreen extends StatelessWidget {
  const OurSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).secondaryHeaderColor,
        ),
      ),
    );
  }
}
