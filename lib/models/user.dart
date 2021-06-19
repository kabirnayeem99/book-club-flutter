import 'package:cloud_firestore/cloud_firestore.dart';

class OurUser {
  final String uid;
  final String email;
  String? fullName;
  Timestamp? accountCreated;

  OurUser({
    required this.email,
    this.fullName,
    this.accountCreated,
    required this.uid,
  });
}
