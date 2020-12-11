import 'package:dsc_iiitdmkl/Backend/DataClasses/Home.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// loads home, events, projects, team
class LoadHomeData extends ChangeNotifier{
  final DatabaseReference databaseRef = FirebaseDatabase().reference();
  Home homeData;

  LoadHomeData();

  void loadHomeData(){
    databaseRef.child('master').onValue
        .listen((event) {
      homeData = Home.fromSnapShot(event.snapshot);
      notifyListeners();
    })
        .onError((err){
      print('Error Loading Home Data : ' + err.toString());
    });
  }
}