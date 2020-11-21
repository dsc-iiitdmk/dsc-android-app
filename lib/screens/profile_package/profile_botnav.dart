import 'package:dsc_iiitdmkl/ThemeData/fontstyle.dart';
import 'package:dsc_iiitdmkl/screens/login_register_package/forgot_pass.dart';
import 'package:dsc_iiitdmkl/services/user_details_firebase.dart';
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

    print("init");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50.0.w),
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Spacer(flex: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  print(UserDetails.firebaseUser);
                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 85,
                      height: 85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 1, style: BorderStyle.solid, color: Font_Style.primaryColor.withOpacity(0.2)),
                          image: DecorationImage(
                              image: AssetImage("assets/userprofiledefault.png"),
                              fit: BoxFit.cover
                          )
                      ),
                      //child: showImage(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 178.w,top: 138.h),
                      child: Container(
                        width: 42.h,
                        height: 42.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Font_Style.primaryColor
                        ),
                        child: Center(
                          child: Icon(Icons.edit,size: 20.h,color: Colors.white,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 38.0.w,),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Shoyab Azmal", textAlign: TextAlign.left, textDirection: TextDirection.ltr, overflow: TextOverflow.clip, style: Font_Style.productsans_ExtraBold(null, 60.0),),
                    SizedBox(height: 8.h,),
                    Text("shaikshoyab01@gmail.com", textDirection: TextDirection.ltr, textAlign: TextAlign.left, overflow: TextOverflow.clip, style: Font_Style.productsans_Regular(null, 46.0),)
                  ],
                ),
              ),
            ],
          ),
          Spacer(flex: 32,),
          _list_title("ACCOUNT",Icons.person_outline),
          _profile_home_list_item("My Profile", context),
          _profile_home_list_item("My Registrations", context),
          _profile_home_list_item("Change Password", context),
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
          _profile_home_list_item("Developers", context),
          _profile_home_list_item("Share with Friends", context),
          _profile_home_list_item("Rate App", context),
          _profile_home_list_item("Privacy Policy", context),
          Spacer(flex: 70,),
          RaisedButton(
            onPressed: logout,
            textColor: Colors.white,
            color: Colors.red,
            padding: EdgeInsets.symmetric(
                vertical: 8.0, horizontal: 25.0),
            child: Text(
              "Logout",
              style: Font_Style.productsans_medium(Colors.white, 50),
            ),
          ),
          Spacer(flex: 30,),
        ],
      ),
    );
  }

  Widget _profile_home_list_item(String title, context){
    return Padding(
      padding: EdgeInsets.only(bottom: 25.0.h),
      child: InkWell(
        onTap: () {
          switch(title) {
            case "Change Password":
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ForgotPassword()),
              );
              break;
            default:
              print("default");
          }
        },
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(title, textAlign: TextAlign.left, textDirection: TextDirection.ltr, overflow: TextOverflow.clip, style: Font_Style.productsans_medium(Font_Style.secondaryColor, 48.0),)),
      ),
    );
  }

  Widget _list_title(String title, IconData icon){
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
