class Profile{
  String name, email, phone, state, dist;

  String getName(){
    return name;
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

  void setName(String name){
    this.name = name;
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

  bool isThisOurCollegeStudent(){
    return email.endsWith("@iiitk.ac.in");
  }

  Profile();
  Profile.load(this.name, this.email, this.phone, this.state, this.dist);
}
