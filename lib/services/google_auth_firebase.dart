import 'package:dsc_iiitdmkl/screens/components/bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;
  GoogleSignIn _googleSignIn = new GoogleSignIn();

  Future<void> handleGoogleSignIn(context,callback) async {

    callback(true,"null");
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);

    var result = (await _auth.signInWithCredential(credential));
    _user = result.user;

    if(_user!=null){
      callback(false,"1");
      //AuthCommon().on_login_succeded(_user,context);

      Navigator.push(context,
        MaterialPageRoute(builder: (context) =>
            BottomNav(currentIndex: 2,)),);
    }
  }

  Future<void> handleGoogleSignOut() async {
    await _auth.signOut().then((onValue) {
      _googleSignIn.signOut();
    });
  }
}