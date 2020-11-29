import 'package:firebase_database/firebase_database.dart';

class Profile{
  String email, phone, state, dist, branch, sem;

  String getSem(){
    return sem;
  }

  String getEmail(){
    return email;
  }

  String getPhone(){
    return phone;
  }

  String getState(){
    return state;
  }

  String getDist(){
    return dist;
  }

  void setEmail(String email){
    this.email = email;
  }

  void setPhone(String phone){
    this.phone = phone;
  }

  void setState(String state){
    this.state = state;
  }

  void setDist(String dist){
    this.dist = dist;
  }

  void setSem(String sem){
    this.sem = sem;
  }

  bool isThisOurCollegeStudent(){
    return email.endsWith("@iiitk.ac.in");
  }

  Profile();
  Profile.load(this.email, this.phone, this.state, this.dist, this.sem, this.branch);
  Profile.fromSnapShot(DataSnapshot snapshot){
    this.state = snapshot.value['state'];
    this.dist = snapshot.value['dist'];
    this.sem = snapshot.value['sem'];
    this.branch = snapshot.value['branch'];
    this.phone = snapshot.value['phone'];
    this.email = snapshot.value['email'];
  }
}
