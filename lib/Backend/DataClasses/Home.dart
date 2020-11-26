// this class contains all data to be needed to show in home
// this will be stored in a "master" named node in firebase RTD

import 'dart:collection';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

class Home{
  List<HomeCard> homeCards;
  String email, gitLink, instaLink;
  double clgLat, clgLon;

  List<HomeCard> getHomeCards(){
    return homeCards;
  }

  String getEmail(){
    return email;
  }

  String getGitLink(){
    return gitLink;
  }

  String getInstaLink(){
    return instaLink;
  }

  double getClgLat(){
    return clgLat;
  }

  double getClgLon(){
    return clgLon;
  }

  void setHomeCards(List<HomeCard> homeCards){
    this.homeCards = homeCards;
  }

  void setEmail(String email){
    this.email = email;
  }

  void setGitLink(String link){
    this.gitLink = link;
  }

  void setInstaLink(String link){
    this.instaLink;
  }

  void setClgLat(double lat){
    this.clgLat = lat;
  }

  void setClgLon(double lon){
    this.clgLon = lon;
  }

  Home();
  Home.load(this.homeCards, this.email, this.gitLink, this.instaLink, this.clgLat, this.clgLon);
  Home.fromSnapShot(DataSnapshot snapshot){
    this.email = snapshot.value['email'];
    this.instaLink = snapshot.value['igLink'];
    this.gitLink = snapshot.value['gitLink'];
    this.clgLat = snapshot.value['clgLat'];
    this.clgLon = snapshot.value['clgLon'];

    homeCards = List();
    List<dynamic> cards = snapshot.value['cards'];
    homeCards.addAll(cards.map((e) => HomeCard.fromJson(jsonEncode( e))));
  }
}

class HomeCard{
  String title;
  String text;

  String getTitle(){
    return title;
  }

  String getText(){
    return text;
  }

  void setTitle(String title){
    this.title = title;
  }

  void setText(String text){
    this.text = text;
  }

  HomeCard();
  HomeCard.load(this.title, this.text);
  HomeCard.fromSnapShot(DataSnapshot snapshot){
    this.title = snapshot.value['q'];
    this.text = snapshot.value['a'];
  }

  HomeCard.fromJson(String json){
    this.title = jsonDecode(json)['q'];
    this.text = jsonDecode(json)['a'];
  }
}