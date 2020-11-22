import 'dart:ui';

import 'package:dsc_iiitdmkl/Data/LocationData.dart';
import 'package:dsc_iiitdmkl/ThemeData/fontstyle.dart';
import 'package:dsc_iiitdmkl/services/user_details_firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileEdit extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProfileEditState();
  }
}

class ProfileEditState extends State<ProfileEdit>{

  String dropdownSelectedYear;
  String dropdownSelectedBranch;
  String dropdownSelectedState;
  String dropdownSelectedDist;
  LocationData _locationData;
  List<String> stateList = new List<String>();

  TextEditingController _phoneTextController = new TextEditingController();
  TextEditingController _userNameTextController = new TextEditingController(text: UserDetails.firebaseUser.displayName);
  TextEditingController _emailTextController = new TextEditingController(text: UserDetails.firebaseUser.email);

  @override
  void initState() {
    super.initState();
    UserDetails.getUserId(context);
    _locationData = new LocationData();
    _locationData.getStateList().then((value) => setState((){stateList = value;}));
  }

  @override
  Widget build(BuildContext context){
   return Scaffold(
     appBar: AppBar(
       leading: InkWell(
         onTap: () {
           //also implement update
           Navigator.of(context).pop();
         },
         child: Icon(
           Icons.arrow_back, color: Font_Style.primaryColor, size: 24.0,),
       ),
       title: Text(
         "My Profile", style: Font_Style.productsans_medium(null, 56),),
       backgroundColor: Colors.white,
     ),
     body: SafeArea(
       child: Container(
         height: MediaQuery.of(context).size.height,
         width: MediaQuery.of(context).size.width,
         child: Column(
           children: [
             Container(
                 width: MediaQuery.of(context).size.width,
                 height: MediaQuery.of(context).size.height / 5,
                 decoration: BoxDecoration(
                   image: DecorationImage(
                     image: new NetworkImage("https://firebasestorage.googleapis.com/v0/b/aegle-e153c.appspot.com/o/HomeTiles%2Faboutus.png?alt=media&token=cfc92220-6077-41ed-8e14-dc654c5e1fc"),
                     fit: BoxFit.fill,
                     colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                   ),
                 ),
                 child: BackdropFilter(
                   filter: ImageFilter.blur(sigmaX: 5,),
                   child: Center(
                     child: Stack(
                       children: <Widget>[
                         Container(
                           width: 120,
                           height: 120,
                           decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(70),
                               border: Border.all(width: 1, style: BorderStyle.solid, color: Font_Style.primaryColor.withOpacity(0.2)),
                               image: DecorationImage(
                                   image: AssetImage("assets/userprofiledefault.png"),
                                   fit: BoxFit.cover
                               )
                           ),
                           //child: showImage(),
                         ),
                         Padding(
                           padding: EdgeInsets.only(left: 95,top: 85),
                           child: Container(
                             width: 50.h,
                             height: 50.h,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(14),
                                 color: Font_Style.primaryColor
                             ),
                             child: Center(
                               child: Icon(Icons.edit,size: 12,color: Colors.white,),
                             ),
                           ),
                         )
                       ],
                     ),
                   ),
                 )
             ),
             Expanded(
               child: Stack(
                 children: <Widget>[
                   Container(
                     padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 50.0.h),
                     child: SingleChildScrollView(
                       child: Column(
                         children: [
                           profileEntry("User Name", false, _userNameTextController, 30, TextInputType.phone),
                           profileEntry("Email Address", false, _emailTextController, 45, TextInputType.phone),
                           profileEntry("Phone Number", true, _phoneTextController, 10, TextInputType.phone),
                           profileDropDownEntry(
                               <String>['1st', '2nd', '3rd', '4th', '5th', '6th', '7th', '8th']
                                   .map<DropdownMenuItem<String>>((String value) {
                                 return DropdownMenuItem<String>(
                                   value: value,
                                   child: Text(value),
                                 );
                               })
                                   .toList(),
                               dropdownSelectedYear,
                               "Select Semester",
                                   (String newValue) {
                                 setState(() {
                                   dropdownSelectedYear = newValue;
                                 });
                               }
                           ),
                           profileDropDownEntry(
                               <String>['Computer Science', 'Electronics & Communications', 'Mechanical', 'Others']
                                   .map<DropdownMenuItem<String>>((String value) {
                                 return DropdownMenuItem<String>(
                                   value: value,
                                   child: Text(value),
                                 );
                               })
                                   .toList(),
                               dropdownSelectedBranch,
                               "Select Branch",
                                   (String newValue) {
                                 setState(() {
                                   dropdownSelectedBranch = newValue;
                                 });
                               }
                           ),
                           profileDropDownEntry(
                               stateList
                                   .map<DropdownMenuItem<String>>((String value) {
                                 return DropdownMenuItem<String>(
                                   value: value,
                                   child: Text(value),
                                 );
                               })
                                   .toList(),
                               dropdownSelectedState,
                               "Select State",
                                   (String newValue) {
                                 setState(() {
                                   dropdownSelectedState = newValue;
                                   dropdownSelectedDist = null;
                                 });
                               }
                           ),
                           profileDropDownEntry(
                               _locationData.getDistrict(dropdownSelectedState)
                                   .map<DropdownMenuItem<String>>((String value) {
                                 return DropdownMenuItem<String>(
                                   value: value,
                                   child: Text(value),
                                 );
                               })
                                   .toList(),
                               dropdownSelectedDist,
                               "Select District",
                                   (String newValue) {
                                 setState(() {
                                   dropdownSelectedDist = newValue;
                                 });
                               }
                           ),
                           SizedBox(height: 150.0.h,),
                         ],
                       ),
                     ),
                   ),
                   Align(
                     alignment: Alignment.bottomCenter,
                     child: Padding(
                       padding: EdgeInsets.symmetric(vertical: 50.0.h),
                       child: RaisedButton(
                         onPressed: () {
                           print("update");
                         },
                         textColor: Colors.white,
                         color: Colors.teal[800],
                         padding: EdgeInsets.symmetric(
                             vertical: 10.0, horizontal: 45.0),
                         child: Text("Update", style: Font_Style.productsans_Bold(Colors.white, 52),),
                       ),
                     ),
                   ),
                 ],
               ),
             ),
           ],
         ),
       ),
     ),
   );
  }

  Widget profileDropDownEntry(List<DropdownMenuItem<String>> items, String dropdownValue, String hint, Function(String) onChange ) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15,),
      margin: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: dropdownSelectedState == null && hint == "Select District" ? Font_Style.primaryColor.withOpacity(0.2) : Font_Style.secondaryColor, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonFormField<String>(
        value: dropdownValue,
        hint: Text("$hint", style: Font_Style.productsans_SemiBold(dropdownSelectedState == null && hint == "Select District" ? Font_Style.primaryColor.withOpacity(0.2) : Font_Style.primaryColor.withOpacity(0.7), 45),),
        icon: Icon(Icons.arrow_drop_down, color: dropdownSelectedState == null && hint == "Select District" ? Font_Style.primaryColor.withOpacity(0.2) : Font_Style.secondaryColor, size: 24.0,),
        iconSize: 24,
        elevation: 16,
        style: Font_Style.productsans_SemiBold(dropdownSelectedState == null && hint == "Select District" ? Font_Style.primaryColor.withOpacity(0.2) : null, 45),
        isExpanded: true,
        onChanged: onChange,
        items: items,
        decoration: InputDecoration.collapsed(hintText: ''),
      ),
    );
  }

  Widget profileEntry(String title, bool enabled, TextEditingController controller, int maxLength, TextInputType textInputType){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      child: TextField(
        onChanged: (text) {
          if(text.length == maxLength) {
            FocusScope.of(context).requestFocus(new FocusNode());
          }
        },
        enabled: enabled,
        scrollPadding: EdgeInsets.all(25),
        controller: controller,
        maxLength: maxLength,
        decoration: Font_Style.setLabelAllBorders(title, null, null, context),
        keyboardType: textInputType,
        cursorColor: Font_Style.secondaryColor.withOpacity(0.3),
        style: Font_Style.productsans_SemiBold(Font_Style.primaryColor.withOpacity(0.7), 45),
      ),
    );
  }
}