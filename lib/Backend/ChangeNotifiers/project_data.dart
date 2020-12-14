import 'dart:convert';

import 'package:dsc_iiitdmkl/Backend/DataClasses/Project.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

// loads home, events, projects, team
class LoadProjectData extends ChangeNotifier{
  final DatabaseReference databaseRef = FirebaseDatabase().reference();
  List<Project> projects;

  LoadProjectData();

  void loadProjects(){
      databaseRef.child("projects").onValue
          .listen((event) {
            projects = List();
            List<dynamic> data = event.snapshot.value;
            data.forEach((element) {
              projects.add(Project.fromJSON(jsonEncode(element)));
            });
            notifyListeners();
      })
          .onError((err){
            print('Error Loading Projects : ' + err.toString());
      });
  }
}