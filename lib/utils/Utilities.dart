import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OurUtilities {
  static showSnackBar(BuildContext context, String messsage) {
    final snackBar = SnackBar(content: Text(messsage));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
