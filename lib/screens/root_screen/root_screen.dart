import 'package:book_club_flutter/screens/home_screen/home_screen.dart';
import 'package:book_club_flutter/screens/login_screen/login_screen.dart';
import 'package:book_club_flutter/screens/no_group_screen/no_group_screen.dart';
import 'package:book_club_flutter/screens/splash_screen/splash_screen.dart';
import 'package:book_club_flutter/states/current_user.dart';
import 'package:book_club_flutter/utils/enums/auth_status_enum.dart';
import 'package:book_club_flutter/utils/resource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OurRootScreen extends StatefulWidget {
  const OurRootScreen({Key? key}) : super(key: key);

  @override
  _OurRootScreenState createState() => _OurRootScreenState();
}

class _OurRootScreenState extends State<OurRootScreen> {
  OurAuthStatus _authStatus = OurAuthStatus.UNKNOWN;

  @override
  void didChangeDependencies() async {
    CurrentUserState _userState =
        Provider.of<CurrentUserState>(context, listen: false);
    OurResource _resource = await _userState.onStartup();

    if (_resource is OurSuccess) {
      if (_userState.getCurrentUser.groupId != null) {
        setState(() {
          _authStatus = OurAuthStatus.IN_GROUP;
        });
      } else {
        setState(() {
          _authStatus = OurAuthStatus.NOT_IN_GROUP;
        });
      }
    } else {
      setState(() {
        _authStatus = OurAuthStatus.NOT_AUTHENTICATED;
      });
      debugPrint(_resource.errorMessage);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    late Widget shownWidget;

    if (_authStatus == OurAuthStatus.NOT_IN_GROUP) {
      shownWidget = OurNoGroupScreen();
    } else if (_authStatus == OurAuthStatus.IN_GROUP) {
      shownWidget = OurHomeScreen();
    } else if (_authStatus == OurAuthStatus.NOT_AUTHENTICATED) {
      shownWidget = OurLoginScreen();
    } else if (_authStatus == OurAuthStatus.UNKNOWN) {
      shownWidget = OurSplashScreen();
    }

    return shownWidget;
  }
}
