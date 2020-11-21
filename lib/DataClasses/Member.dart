class Member{
  String name, batch, gitLink, instaLink, linkedinLink, image, domain; // domain means android, web, etc

  String getName(){
    return name;
  }

  String getBatch(){
    return batch;
  }

  String getGitLink(){
    return gitLink;
  }

  String getInstaLink(){
    return instaLink;
  }

  String getLinkedinLink(){
    return linkedinLink;
  }

  String getImage(){
    return image;
  }

  String getDomain(){
    return domain;
  }

  void setName(String name){
    this.name = name;
  }

  void setBatch(String batch){
    this.batch = batch;
  }

  void setGitLink(String link){
    this.gitLink = link;
  }

  void setInstaLink(String link){
    this.instaLink = link;
  }

  void setLinkedinLink(String link){
    this.linkedinLink = link;
  }

  void setImage(String image){
    this.image = image;
  }

  void setDomain(String domain){
    this.domain = domain;
  }

  Member();
  Member.load(this.name, this.batch, this.gitLink, this.instaLink, this.linkedinLink, this.image, this.domain);
}