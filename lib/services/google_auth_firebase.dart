import 'package:dsc_iiitdmkl/Backend/DataClasses/Profile.dart';
import 'package:dsc_iiitdmkl/screens/components/bottom_nav.dart';
import 'package:dsc_iiitdmkl/services/user_details_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth{

  static Profile userProfile = new Profile();

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static User _user;
  static GoogleSignIn _googleSignIn = new GoogleSignIn();

  static Future<void> handleGoogleSignIn(context,callback) async {

    callback(true,"null");
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);

    var result = (await _auth.signInWithCredential(credential));
    _user = result.user;

    if(_user != null){
      callback(false,"1");

      await FirebaseDatabase.instance.reference().child('Users/${FirebaseAuth.instance.currentUser.uid}/email').set(_user.email);
      UserDetails.getUserId(context);
      updateUserDb();

      Navigator.push(context,
        MaterialPageRoute(builder: (context) =>
            BottomNav(currentIndex: 2,)),);
    }
  }

  static void updateUserDb() async{
    userProfile.email = UserDetails.firebaseUser.email.toString();

    await UserDetails.updateUserProfile(userProfile);
  }

  static Future<void> handleGoogleSignOut() async {
    await _auth.signOut().then((onValue) {
      _googleSignIn.signOut();
    });
  }
}