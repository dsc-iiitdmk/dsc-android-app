// this class contains all data to be needed to show in home
// this will be stored in a "master" named node in firebase RTD

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
}