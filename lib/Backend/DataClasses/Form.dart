// still to be completed

class Form{
  String formID, topImage;
  List<FormEntry> entries;

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

  Form();
  Form.load(this.formID, this.topImage, this.entries);
}

// Different classes to be made for different entry types and all of them will extend this class
class FormEntry{
  var value;
  String entryType;
  String question;
  bool isMandate;

  static final String ENTRY_TEXT  =  "text";
  static final String ENTRY_NUMBER  =  "number";
  static final String ENTRY_RADIO  =  "radio";
  static final String ENTRY_CHECKBOX  =  "checkbox";
  static final String ENTRY_RANGE = "range";
  static final String ENTRY_IMAGE = "image";
  static final String ENTRY_FILE = "file";


  getValue(){
    return value;
  }

  String getEntryType(){
    return entryType;
  }

  bool getIsMandate(){
    return isMandate;
  }

  String getQuestion(){
    return question;
  }

  void setValue(var value){
    this.value = value;
  }

  void setEntryType(String entryType){
    this.entryType = entryType;
  }

  void setIsMandate(bool isMandate){
    this.isMandate = isMandate;
  }

  void setQuestion(String question){
    this.question = question;
  }

  FormEntry();
  FormEntry.load(this.value, this.entryType, this.isMandate, this.question);
}