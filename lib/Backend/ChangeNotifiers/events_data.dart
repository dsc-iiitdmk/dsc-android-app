import 'dart:convert';

import 'package:dsc_iiitdmkl/Backend/DataClasses/Events.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

// loads home, events, projects, team
class LoadEventsData extends ChangeNotifier{
  final DatabaseReference databaseRef = FirebaseDatabase().reference();
  List<Events> pastEvents;
  List<Events> ongoingEvents;
  List<Events> futureEvents;
  bool dataLoaded = false;

  LoadEventsData();

  void loadEvents(){
    if(!dataLoaded){
      pastEvents = List();
      ongoingEvents = List();
      futureEvents = List();

      databaseRef.child("events").once().then((value){
        List<dynamic> data = value.value;
        int currentTime = DateTime.now().millisecondsSinceEpoch;
        for(dynamic event in data){
          Events e = Events.fromJSON(jsonEncode(event));
          if(e.startTime < currentTime && e.endTime < currentTime){
            pastEvents.add(e);
          }else if(e.startTime < currentTime && e.endTime > currentTime){
            ongoingEvents.add(e);
          }else{
            futureEvents.add(e);
          }
        }

        dataLoaded = true;
        notifyListeners();
      })
      .catchError((err){
        print('Error Loading Events ' + err.toString());
      });
    }else{
      notifyListeners();
    }
  }
}