import 'package:dsc_iiitdmkl/Backend/DataClasses/Home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// loads home, events, projects, team
class LoadHomeData extends ChangeNotifier{
  final DatabaseReference databaseRef = FirebaseDatabase().reference();
  Home homeData;

  LoadHomeData();

  // List<Member> membersList;
  // List<Project> projectList;

  void loadHomeData(){
    databaseRef.child('master').once().then((value){
      homeData = Home.fromSnapShot(value);
      notifyListeners();
    }).catchError((err){
      print(err.toString());
    });
  }

  // void loadMembers(){
  //   databaseRef.child('members').once().then((snap){
  //     List<dynamic> members = snap.value;
  //     membersList = members.map((e) => Member.fromSnapShot(e));
  //     notifyListeners();
  //   });
  // }
  //
  // void loadProjects(){
  //   databaseRef.child('projects').once().then((snap){
  //     List<dynamic> projects = snap.value;
  //     projectList = projects.map((e) => Project.fromSnapShot(e));
  //     notifyListeners();
  //   });
  // }
}