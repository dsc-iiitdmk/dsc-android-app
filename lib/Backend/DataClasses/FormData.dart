// still to be completed

import 'dart:convert';

class FormData{
  String formID, topImage, desc, title;
  List<FormEntry> entries;
  List<dynamic> responses; // index of this is in same order as entries. values could be anything

  String getFormID(){
    return formID;
  }

  String getTopImage(){
    return topImage;
  }

  List<FormEntry> getEntries(){
    return entries;
  }

  void setFormID(String formID){
    this.formID = formID;
  }

  void setTopImage(String topImage){
    this.topImage = topImage;
  }

  void setEntries(List<FormEntry> entries){
    this.entries = entries;
  }

  FormData();
  FormData.load(this.formID, this.topImage, this.entries, this.responses, this.title, this.desc);
  FormData.fromJSON(String jsonStr){
    dynamic json = jsonDecode(jsonStr);

    formID = json['id'];
    topImage = json['topImage'];
    desc = json['desc'];
    title = json['title'];

    List<dynamic> tmpEntries = json['entries'];
    entries = new List();
    responses = new List();
    for(dynamic entry in tmpEntries){
      entries.add(new FormEntry.fromJSON(jsonEncode(entry)));
      responses.add(null);
    }
  }
}

// Different classes to be made for different entry types and all of them will extend this class
class FormEntry{
  var value;
  String type;
  String title;
  bool isMandate;
  List<String> checks; // only usable when type = check
  List<String> radios; // only usable when type = radio
  int inputLength; // only usable when type = text or num

  static final String ENTRY_TEXT  =  "txt";
  static final String ENTRY_NUMBER  =  "num";
  static final String ENTRY_RADIO  =  "rad";
  static final String ENTRY_CHECKBOX  =  "chk";
  static final String ENTRY_RANGE = "rng"; // skip
  static final String ENTRY_IMAGE = "img"; // skip
  static final String ENTRY_FILE = "fil"; // skip


  FormEntry();
  FormEntry.load(this.value, this.isMandate, this.title, this.type);
  FormEntry.fromJSON(String jsonStr){
    dynamic json = jsonDecode(jsonStr);
    type = json['type'];
    title = json['title'];
    isMandate = json['isMandate'];

    if(type == ENTRY_TEXT || type == ENTRY_NUMBER){
      inputLength = json['len'];
    }

    if(type == ENTRY_CHECKBOX){
      List<dynamic> c = json['checks'];
      checks = new List();
      for(dynamic a in c){
        checks.add(a.toString());
      }
    }

    if(type == ENTRY_RADIO){
      List<dynamic> r = json['radios'];
      radios = new List();
      for(dynamic a in r){
        radios.add(a.toString());
      }
    }
  }
}