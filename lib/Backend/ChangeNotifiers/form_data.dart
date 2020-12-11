import 'dart:convert';

import 'package:dsc_iiitdmkl/Backend/DataClasses/FormData.dart';
import 'package:dsc_iiitdmkl/Backend/DataClasses/FormResponse.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class FormData_Data extends ChangeNotifier{
  FormData formData;
  List<String> myForms_FormIDs;
  String formIDLoaded = "";
  Map<String, FormResponse> myForms;
  Map<String, FormData> formDataGlobalList = new Map();

  void loadMyForms(){
    print('Loading my Forms !~!!!');
    FirebaseDatabase.instance
        .reference().child("response/${FirebaseAuth.instance.currentUser.uid}")
        .orderByChild("time")
        .onValue.listen((event) {
          try{
            myForms_FormIDs = new List();
            myForms = new Map();
            if(event.snapshot != null){
              print('snapshot : ' + jsonEncode(event.snapshot.value));
              Map<dynamic, dynamic> data = event.snapshot.value;
              for(MapEntry<dynamic, dynamic> entry in data.entries){
                FormResponse response = new FormResponse.fromJSON(jsonEncode(entry.value));
                myForms_FormIDs.add(response.formID);
                myForms.putIfAbsent(response.formID, () => response);
              }
            }
            notifyListeners();
          }catch(ex){
            print('Error Loading my forms : ' + ex.toString());
          }
    });
  }

  void loadForm(String formId){
    if(formData != null && formIDLoaded == formId){
      return;
    }
    FirebaseDatabase.instance
        .reference().child('/forms/${formId}')
        .once()
        .then((snap){
          try{
            formIDLoaded = formId;
            formData = new FormData.fromJSON(jsonEncode(snap.value));

            // loading responses
            if(myForms != null && myForms.containsKey(formId)){
              if(formData.responses.length >= myForms[formId].responses.length){
                formData.responses.replaceRange(0, myForms[formId].responses.length - 1, myForms[formId].responses);
              }
            }

            notifyListeners();
          }catch(ex){
            print('Error Getting forms data ::::' + ex.toString());
          }

    })
        .catchError((err){
          print('Error Loading Form Data : ' + err.toString());
          formData = null;
          notifyListeners();
    });
  }
}