import 'dart:convert';

class FormResponse{
  String formID;
  String title;
  int time;
  List<dynamic> responses;

  FormResponse();
  FormResponse.load(this.formID, this.time, this.responses);
  FormResponse.fromJSON(String strJson){
    dynamic json = jsonDecode(strJson);
    formID = json['formID'];
    time = json['time'];
    title = json['title'];
    responses = json['responses'];
  }
}