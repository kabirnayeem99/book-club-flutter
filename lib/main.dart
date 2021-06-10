import 'package:book_club_flutter/screens/login_screen/login_screen.dart';
import 'package:book_club_flutter/utils/our_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: OurTheme().buildTheme(),
      home: OurLoginScreen(),
    );
  }
}
