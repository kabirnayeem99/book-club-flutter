import 'package:cloud_firestore/cloud_firestore.dart';

class OurUser {
  String? uid;
  String? email;
  String? fullName;
  Timestamp? accountCreated;
  String? groupId;

  OurUser({
    this.email,
    this.fullName,
    this.accountCreated,
    this.uid,
    this.groupId,
  });

  @override
  String toString() {
    String _userToString = "\n"
        "\n=== USER INFO ===\n"
        "email -> ${email ?? "No email"}\n"
        "uid -> ${uid ?? "No uid"}\n"
        "accountCreated -> ${accountCreated ?? "No account creation date"}\n"
        "full name -> ${fullName ?? "No full Name"}\n"
        "group id -> ${groupId ?? "No group id"}\n"
        "\n"
        "\n";
    return _userToString;
  }
}
