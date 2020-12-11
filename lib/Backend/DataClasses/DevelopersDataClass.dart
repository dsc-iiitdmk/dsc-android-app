import 'dart:convert';

class DevelopersDataClass {
  String devName, devEmail, devImgUrl, devGitLink, devInstaLink, devLinkedinLink;

  String getDevName() {
    return devName;
  }

  String getDevEmail() {
    return devEmail;
  }

  String getDevImgUrl() {
    return devImgUrl;
  }

  String getGitLink() {
    return devGitLink;
  }

  String getInstaLink() {
    return devInstaLink;
  }

  String getLinkedinLink() {
    return devLinkedinLink;
  }

  void setDevName(String devName) {
    this.devName = devName;
  }

  void setDevEmail(String devEmail) {
    this.devEmail = devEmail;
  }

  void setDevImgUrl(String devImgUrl) {
    this.devImgUrl = devImgUrl;
  }

  void setDevGitLink(String devGitLink) {
    this.devGitLink = devGitLink;
  }

  void setDevInstaLink(String devInstaLink) {
    this.devInstaLink = devInstaLink;
  }

  void setDevLinkedinLink(String devLinkedinLink) {
    this.devLinkedinLink = devLinkedinLink;
  }

  DevelopersDataClass();
  DevelopersDataClass.load(this.devName, this.devEmail, this.devImgUrl, this.devGitLink, this.devInstaLink, this.devLinkedinLink);

  DevelopersDataClass.fromJSON(String json) {
    dynamic snapshotData = jsonDecode(json);
    devName = snapshotData["name"];
    devEmail = snapshotData["email"];
    devImgUrl = snapshotData["devImgUrl"];
    devGitLink = snapshotData["gitLink"];
    devInstaLink = snapshotData["instaLink"];
    devLinkedinLink = snapshotData["linkedinLink"];
  }
}