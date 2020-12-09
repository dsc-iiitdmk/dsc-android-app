import 'dart:convert';

import 'package:dsc_iiitdmkl/Backend/DataClasses/Events.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

// loads home, events, projects, team
class LoadEventsData extends ChangeNotifier{
  final DatabaseReference databaseRef = FirebaseDatabase().reference();
  List<Events> pastEvents = List();
  List<Events> ongoingEvents = List();
  List<Events> futureEvents = List();
  bool dataLoaded = false;

  LoadEventsData();

  void loadEvents(){
    databaseRef.child("events").once().then((value){
      pastEvents = List();
      ongoingEvents = List();
      futureEvents = List();
      List<dynamic> data = value.value;
      int currentTime = DateTime.now().millisecondsSinceEpoch;
      for(dynamic event in data){
        Events e = Events.fromJSON(jsonEncode(event));
        if(e.startTime < currentTime && e.endTime < currentTime){
          pastEvents.add(e);
        }else if(e.startTime < currentTime && e.endTime > currentTime){
          ongoingEvents.add(e);
        }else {
          futureEvents.add(e);
        }
      }
      dataLoaded = true;
      notifyListeners();
    })
    .catchError((err){
      print('Error Loading Events ' + err.toString());
    });
  }
}