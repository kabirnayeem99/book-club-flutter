import 'package:book_club_flutter/models/user.dart';
import 'package:book_club_flutter/utils/resource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OurDatabase {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<OurResource> saveUserToDb(OurUser user) async {
    late OurResource _resource;
    try {
      await _firestore.collection("users").doc(user.uid!).set({
        "accountCreated": Timestamp.now(),
        "email": user.email,
        "fullName": user.fullName,
      });
      _resource = OurSuccess(null);
    } catch (e) {
      _resource = OurError(e.toString());
    }
    return _resource;
  }

  Future<OurResource> getUserInfoFromUid(String uid) async {
    OurResource _resource;

    try {
      OurUser _user = OurUser();

      DocumentSnapshot snapshot =
          await _firestore.collection("users").doc(uid).get();

      Map _userMap = snapshot.data() as Map<String, dynamic>;

      _user.uid = uid;
      _user.fullName = _userMap["fullName"];
      _user.email = _userMap["email"];
      _user.accountCreated = _userMap["accountCreated"];
      _user.groupId = _userMap["groupId"];

      return _resource = OurSuccess(_user);
    } catch (e) {
      _resource = OurError(e.toString());
    }
    return _resource;
  }

  Future<OurResource> createGroupInDb(String groupName, String userUid) async {
    OurResource _resource;

    try {
      List<String> members = [userUid];

      DocumentReference _docRef = await _firestore.collection("groups").add({
        "name": groupName,
        "leader": userUid,
        "groupCreated": Timestamp.now(),
        "members": members,
      });

      await _firestore
          .collection("users")
          .doc(userUid)
          .update({"groupId": _docRef.id});

      _resource = OurSuccess(_docRef);
    } catch (e) {
      _resource = OurError(e.toString());
    }
    return _resource;
  }

  Future<OurResource> joinGroup(String groupId, String userUid) async {
    OurResource _resource;

    try {
      List<String> members = [userUid];

      await _firestore.collection("groups").doc(groupId).update({
        "members": FieldValue.arrayUnion(members),
      });

      await _firestore
          .collection("users")
          .doc(userUid)
          .update({"groupId": groupId});

      _resource = OurSuccess(null);
    } catch (e) {
      _resource = OurError(e.toString());
    }
    return _resource;
  }
}
