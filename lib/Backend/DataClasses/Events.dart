import 'dart:convert';

// for time being formID is going to be google form link
class Events{
  String name, desc, img;
  int startTime, endTime; // millis
  String formID; //null if no form
  bool formAllowForeign, editable; // should we allow clg outsiders to register?

  String getName(){
    return name;
  }

  String getDesc(){
    return desc;
  }

  String getFormID(){
    return formID;
  }

  bool getFormAllowForeign(){
    return formAllowForeign;
  }

  void setName(String name){
    this.name =  name;
  }

  void setDesc(String desc){
    this.desc = desc;
  }

  void setFormID(String formID){
    this.formID = formID;
  }

  void setFormAllowForeign(bool allow){
    this.formAllowForeign = allow;
  }

  Events();
  Events.load(this.name, this.desc, this.startTime, this.endTime, this.formID, this.img, this.formAllowForeign, this.editable);
  Events.fromJSON(String json){
    dynamic snapshot = jsonDecode(json);
    name = snapshot['name'];
    desc = snapshot['desc'];
    startTime = snapshot['startTime'];
    endTime = snapshot['endTime'];
    formID = snapshot['formID'];
    img = snapshot['img'];
    formAllowForeign = snapshot['allowForeign'];
    editable = snapshot['formEditable'];
  }

}