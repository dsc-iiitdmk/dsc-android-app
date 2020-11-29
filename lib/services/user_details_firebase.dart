import 'package:dsc_iiitdmkl/Backend/DataClasses/Profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class UserDetails {
  static final UserDetails _singletonUserDetails = UserDetails._internal();

  factory UserDetails() {
    return _singletonUserDetails;
  }

  UserDetails._internal();


  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static var firebaseUser;

  static getUserId(BuildContext context) {
    firebaseUser = _auth.currentUser;
    if(firebaseUser != null)
      return firebaseUser;
    else
      Navigator.pushNamed(context, "login_register");
  }

  static signOut() async{
    await _auth.signOut();
    firebaseUser = null;
  }

  static void updateUserProfile(Profile profile){
    Map<String, dynamic> data = Map();
    data.putIfAbsent("branch", () => profile.branch);
    data.putIfAbsent("state", () => profile.state);
    data.putIfAbsent("dist", () => profile.dist);
    data.putIfAbsent("sem", () => profile.sem);
    data.putIfAbsent("email", () => profile.email);
    data.putIfAbsent("phone", () => profile.phone);

    FirebaseDatabase.instance.reference().child('Users/${FirebaseAuth.instance.currentUser.uid}')
        .update(data);
  }

  static Future<Profile> loadUserProfile() async{
    DataSnapshot snapshot = await FirebaseDatabase.instance.reference().child('Users/${_auth.currentUser.uid}')
        .once();
    return Profile.fromSnapShot(snapshot);
  }
}