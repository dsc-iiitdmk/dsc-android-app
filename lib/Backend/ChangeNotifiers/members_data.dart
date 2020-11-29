import 'dart:collection';
import 'dart:convert';

import 'package:dsc_iiitdmkl/Backend/DataClasses/Member.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

// loads home, events, projects, team
class LoadMembersData extends ChangeNotifier{
  final DatabaseReference databaseRef = FirebaseDatabase().reference();
  HashMap<String, List<Member>> membersList;
  bool dataLoaded = false;

  LoadMembersData();

  void loadMembers(){
    if(membersList == null) {
      membersList = HashMap();
      databaseRef.child("members").once().then((snapshot) {
        Map<dynamic, dynamic> data = snapshot.value;
        data.forEach((key, value) {
          List<dynamic> list = value;
          List<Member> mList = List();
          for (dynamic d in list) {
            mList.add(Member.fromJSON(jsonEncode(d)));
          }
          membersList.putIfAbsent(key, () => mList);
        });
        dataLoaded = true;
        notifyListeners();
      });
    }else{
      notifyListeners();
    }
  }
}