import 'package:flutter/material.dart';

/// A white rounded corner customer card style container
/// that is used throughout the app
/// this container takes a widget as a parameter,
/// which will be shown inside this container.
class OurContainerWidget extends StatelessWidget {
  final Widget child;

  const OurContainerWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 12.0,
            spreadRadius: 1.0,
            offset: Offset(4.0, 4.0),
          ),
        ],
      ),
      child: child,
    );
  }
}
