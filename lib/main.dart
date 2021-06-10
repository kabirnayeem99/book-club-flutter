import 'package:book_club_flutter/screens/login_screen/login_screen.dart';
import 'package:book_club_flutter/states/current_user.dart';
import 'package:book_club_flutter/utils/our_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  // firebase
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(OurApp());
  } catch (e) {
    print(e);
  }
}

class OurApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CurrentUserState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: OurTheme().buildTheme(),
        home: OurLoginScreen(),
      ),
    );
  }
}
