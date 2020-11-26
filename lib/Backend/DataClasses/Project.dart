import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

class Project{
  String name;
  String desc;
  String gitLink;

  String getName(){
    return name;
  }

  String getDesc(){
    return desc;
  }

  String getGitLink(){
    return gitLink;
  }

  void setGitLink(String link){
    this.gitLink = link;
  }

  void setDesc(String desc){
    this.desc = desc;
  }

  void setName(String name){
    this.name = name;
  }

  Project.load(this.name, this.desc, this.gitLink);
  Project();
  Project.fromJSON(String json){
    this.name = jsonDecode(json)['name'];
    this.desc = jsonDecode(json)['desc'];
    this.gitLink = jsonDecode(json)['gitLink'];
  }
}