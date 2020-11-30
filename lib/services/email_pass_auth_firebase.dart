import 'dart:async';

import 'package:dsc_iiitdmkl/Backend/DataClasses/Profile.dart';
import 'package:dsc_iiitdmkl/screens/components/bottom_nav.dart';
import 'package:dsc_iiitdmkl/services/user_details_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:flutter/material.dart';

class EmailPasswordAuth {

  static Profile userProfile = new Profile();

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future signInWithEmailAndPassword(String email, String password, BuildContext context, callback) async {
    try{
      User firebaseUser = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user;
      if(firebaseUser != null && firebaseUser.emailVerified) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNav(currentIndex: 2,)),);
      }
      else{
        print("Email not verified yet");
        await firebaseUser.sendEmailVerification();
        callback(ButtonState.success,"1");
        final popup=BeautifulPopup(template: TemplateNotification,context: context);
        popup.show(title: "Email Verification",content: "We have sent a verification link to your email please verify to proceed",
            actions:[popup.button(label: 'Close',
                onPressed: (){
                  callback(ButtonState.idle,"1");
                  Navigator.of(context).pop();
                }),
              popup.button(
                label: 'Proceed',
                onPressed: () async{
                  var user= await _auth.currentUser;
                  await user.reload();
                  user=await _auth.currentUser;
                  print(user.emailVerified);
                  if(user != null && user.emailVerified){
                    Navigator.of(context).pop();
                    UserDetails.getUserId(context);
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>
                          BottomNav(currentIndex: 2,)),);
                  }else{ //////////////////////////
                    print("Email not verified yet");
                  }
                },
              )
            ],barrierDismissible: false,close: Container()
        );
      }
    }catch(e) {
      final errorpopup=BeautifulPopup(template: TemplateNotification,context: context,);
      errorpopup.show(title: "invalid field",content: "No user exists with current fields",
          actions:[errorpopup.button(label: 'Close',
            onPressed: (){
              callback(ButtonState.idle,"1");
              Navigator.of(context).pop();
            },),
          ] ,barrierDismissible: false,close: Container());
      print("error 2");
      print(e.toString());
    }
  }

  static Future signUpWithEmailAndPassword(String email, String password, String name, BuildContext context, callback) async {
    try{
      var result = await _auth.createUserWithEmailAndPassword(email: email, password: password).catchError((e){
        print(e);
        final errorpopup=BeautifulPopup(template: TemplateNotification,context: context,);
        errorpopup.show(title: "Email Already exits",content: "The email you have entered is already registered please try to login or enter another email",
            actions:[errorpopup.button(label: 'Close',
              onPressed: (){
                callback(ButtonState.idle,"1");
                Navigator.of(context).pop();
              },),
            ] ,barrierDismissible: false,close: Container());

      });
      if(result != null){
        User firebaseUser = result.user;
        await firebaseUser.sendEmailVerification();
        callback(ButtonState.success,"1");
        final popup=BeautifulPopup(template: TemplateNotification,context: context);
        popup.show(title: "Email Verification",content: "We have sent a verification link to your email please verify to proceed",
            actions:[popup.button(label: 'Close',
                onPressed: (){
                  callback(ButtonState.idle,"1");
                  Navigator.of(context).pop();
                }),
              popup.button(
                label: 'Proceed',
                onPressed: () async{
                  var user= await _auth.currentUser;
                  await user.reload();
                  user = await _auth.currentUser;
                  print(user.emailVerified);
                  if(user != null && user.emailVerified){
                    user.updateProfile(displayName: name);
                    UserDetails.getUserId(context);
                    updateUserDb();
                    Navigator.of(context).pop();
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>
                          BottomNav(currentIndex: 2,)),);
                  }else{
                    print("Email not verified yet");
                  }
                },
              )
            ],barrierDismissible: false,close: Container() );
      }
    }catch(e){
      print(e.toString());
    }
  }

  static void updateUserDb() async{
    userProfile.email = FirebaseAuth.instance.currentUser.email;
    userProfile.name = FirebaseAuth.instance.currentUser.displayName;
    userProfile.phone = userProfile.phone == null || userProfile.phone == "" ? "" : userProfile.phone;
    userProfile.sem = userProfile.sem == null || userProfile.sem == "" ? "" : userProfile.sem;
    userProfile.branch = userProfile.branch == null || userProfile.branch == "" ? "" : userProfile.branch;
    userProfile.state = userProfile.state == null || userProfile.state == "" ? "" : userProfile.state;
    userProfile.dist = userProfile.dist == null || userProfile.dist == "" ? "" : userProfile.dist;

    await UserDetails.updateUserProfile(userProfile);
  }

  static Future resetPassword(String email,context) async{
    try{
      await _auth.sendPasswordResetEmail(email: email);

    }catch(e){
      print(e.toString());
    }
  }

  static Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }
}