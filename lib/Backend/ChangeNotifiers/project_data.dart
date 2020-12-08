import 'dart:collection';
import 'dart:convert';

import 'package:dsc_iiitdmkl/Backend/DataClasses/Home.dart';
import 'package:dsc_iiitdmkl/Backend/DataClasses/Member.dart';
import 'package:dsc_iiitdmkl/Backend/DataClasses/Project.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

// loads home, events, projects, team
class LoadProjectData extends ChangeNotifier{
  final DatabaseReference databaseRef = FirebaseDatabase().reference();
  List<Project> projects;

  LoadProjectData();

  void loadProjects(){
      databaseRef.child("projects").once().then((snapshot){
        projects = List();
        List<dynamic> data = snapshot.value;
        data.forEach((element) {
          projects.add(Project.fromJSON(jsonEncode(element)));
        });
        notifyListeners();
      });
  }
}