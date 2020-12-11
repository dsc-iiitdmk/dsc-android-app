import 'dart:convert';

import 'package:dsc_iiitdmkl/Backend/DataClasses/DevelopersDataClass.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class LoadDevelopersData extends ChangeNotifier {
  final DatabaseReference databaseRef = FirebaseDatabase().reference();
  List<DevelopersDataClass> developerDataList;

  LoadDevelopersData();

  void loadDevelopersData(){
    databaseRef.child("developers").onValue.listen((event) {
      developerDataList = List();
      List<dynamic> developerDataSnapshot = event.snapshot.value;
      developerDataSnapshot.forEach((element) {
        developerDataList.add(DevelopersDataClass.fromJSON(jsonEncode(element)));
      });
      print("fuckyou");
      print(developerDataList);
      notifyListeners();
    }).onError((err){
      print('Error Loading Developers Data ' + err.toString());
    });
  }
}