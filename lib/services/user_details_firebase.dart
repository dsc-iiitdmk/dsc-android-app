import 'package:firebase_auth/firebase_auth.dart';
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
}