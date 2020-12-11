import 'package:dsc_iiitdmkl/ThemeData/fontstyle.dart';
import 'package:dsc_iiitdmkl/screens/profile_package/ProfileEdit.dart';
import 'package:dsc_iiitdmkl/services/user_details_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileBotNav extends StatefulWidget {
  @override
  _ProfileBotNavState createState() => _ProfileBotNavState();
}

class _ProfileBotNavState extends State<ProfileBotNav> {
  @override
  void initState() {
    UserDetails.getUserId(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0.w),
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Spacer(flex: 15,),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 500),
                      pageBuilder: (context, __, ___) => ProfileEdit()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Hero(
                  tag: "display_pic",
                  child: Container(
                    width: 87,
                    height: 87,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 1, style: BorderStyle.solid, color: Font_Style.primaryColor.withOpacity(0.2)),
                        image: DecorationImage(
                            image: FirebaseAuth.instance.currentUser.photoURL == null ? AssetImage("assets/userprofiledefault.png") : NetworkImage(FirebaseAuth.instance.currentUser.photoURL),
                            fit: BoxFit.cover
                        )
                    ),
                    //child: showImage(),
                  ),
                ),
                SizedBox(width: 38.0.w,),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("${UserDetails.firebaseUser.displayName}", textAlign: TextAlign.left, textDirection: TextDirection.ltr, overflow: TextOverflow.clip, style: Font_Style.productsans_ExtraBold(null, 60.0),),
                      SizedBox(height: 8.h,),
                      Text("${UserDetails.firebaseUser.email}", textDirection: TextDirection.ltr, textAlign: TextAlign.left, overflow: TextOverflow.clip, style: Font_Style.productsans_Regular(null, 46.0),)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Spacer(flex: 32,),
          _listTitle("ACCOUNT",Icons.person_outline),
          _profileHomeListItem("My Profile", context),
          _profileHomeListItem("My Registrations", context),
          _profileHomeListItem("Change Password", context),
          Spacer(flex: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ImageIcon(AssetImage("assets/grading.png"),size: 20,color: Font_Style.primaryColor,),
              SizedBox(width: 15.w,),
              Text("ABOUT US",style: Font_Style.productsans_ExtraBold(null, 48.0),),
            ],),
          SizedBox(
            height: 12.0.h,
          ),
          Padding(
            padding: EdgeInsets.only(right: 52.0.w),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: Font_Style.primaryColor.withOpacity(0.20),
            ),
          ),
          SizedBox(
            height: 40.5.h,
          ),
          _profileHomeListItem("Developers", context),
          _profileHomeListItem("Share with Friends", context),
          _profileHomeListItem("Rate App", context),
          _profileHomeListItem("Privacy Policy", context),
          Spacer(flex: 60,),
          RaisedButton(
            onPressed: logout,
            textColor: Colors.white,
            color: Colors.red,
            padding: EdgeInsets.symmetric(
                vertical: 8.0, horizontal: 25.0),
            child: Text(
              "Logout",
              style: Font_Style.productsans_Bold(Colors.white, 52),
            ),
          ),
          Spacer(flex: 20,),
        ],
      ),
    );
  }

  Widget _profileHomeListItem(String title, context){
    return Padding(
      padding: EdgeInsets.only(bottom: 42.0.h,),
      child: InkWell(
        onTap: () {
          switch(title) {
            case "My Profile":
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 500),
                      pageBuilder: (context, __, ___) => ProfileEdit()));
              break;
            case "My Registrations":
              Navigator.pushNamed(context, "my_registration");
              break;
            case "Change Password":
              Navigator.pushNamed(context, "forgot_pass");
              break;
            case "Privacy Policy":
              Navigator.pushNamed(context, "privacy_policy");
              break;
            case "Developers":
              Navigator.pushNamed(context, "developers");
              break;
            default:
              print("default");
          }
        },
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(title, textAlign: TextAlign.left, textDirection: TextDirection.ltr, overflow: TextOverflow.clip, style: Font_Style.productsans_medium(Font_Style.secondaryColor, 50.0),)),
      ),
    );
  }

  Widget _listTitle(String title, IconData icon){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(icon, size: 20, color: Font_Style.primaryColor,),
            SizedBox(width: 15.w,),
            Text(title,style: Font_Style.productsans_ExtraBold(null, 48.0),),
          ],),
        SizedBox(
          height: 12.0.h,
        ),
        Padding(
          padding: EdgeInsets.only(right: 52.0.w),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Font_Style.primaryColor.withOpacity(0.20),
          ),
        ),
        SizedBox(
          height: 40.5.h,
        )
      ],
    );
  }

  void logout() {
    print(UserDetails.firebaseUser);
    if(UserDetails.firebaseUser != null) {
      UserDetails.signOut();
    }
    Navigator.pushNamed(context, "login_register");
  }
}
