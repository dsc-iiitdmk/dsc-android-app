class Profile{
  static String name, email, phone, state, dist;

  static String getName(){
    return name;
  }

  static String getEmail(){
    return email;
  }

  static String getPhone(){
    return phone;
  }

  static String getState(){
    return state;
  }

  static String getDist(){
    return dist;
  }

  static bool isThisOurCollegeStudent(){
    return email.endsWith("@iiitk.ac.in");
  }

  Profile();
  //Profile.load(this.name, this.email, this.phone, this.state, this.dist);
}