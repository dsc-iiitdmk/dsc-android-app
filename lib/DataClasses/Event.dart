
class Event{
  String name, desc;
  double time; // millis
  String formID; //null if no form
  bool formAllowForeign; // should we allow clg outsiders to register?

  String getName(){
    return name;
  }

  String getDesc(){
    return desc;
  }

  String getFormID(){
    return formID;
  }

  double getTime(){
    return time;
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

  void setTime(double time){
    this.time = time;
  }

  void setFormID(String formID){
    this.formID = formID;
  }

  void setFormAllowForeign(bool allow){
    this.formAllowForeign = allow;
  }

  Event();
  Event.load(this.name, this.desc, this.time, this.formID);

}