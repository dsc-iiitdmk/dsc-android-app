import 'dart:io';
import 'dart:ui';

import 'package:dsc_iiitdmkl/Backend/DataClasses/Profile.dart';
import 'package:dsc_iiitdmkl/Data/LocationData.dart';
import 'package:dsc_iiitdmkl/ThemeData/fontstyle.dart';
import 'package:dsc_iiitdmkl/services/user_details_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileEdit extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProfileEditState();
  }
}

class ProfileEditState extends State<ProfileEdit>{

  Profile userProfile;
  LocationData _locationData;
  List<String> stateList = new List<String>();
  bool isProfileLoaded = false;

  TextEditingController _phoneTextController = new TextEditingController();
  TextEditingController _studentNameTextController = new TextEditingController();
  TextEditingController _emailTextController = new TextEditingController();

  File _imageFile;
  bool changedNow = false;
  final _imagePicker = new ImagePicker();
  
  List<ProfilePhotoSelectType> profilePhotoSelectList=[
    ProfilePhotoSelectType(title: "Open Gallery", icon:  Icon(Icons.photo_library, color: Colors.white,),),
    ProfilePhotoSelectType(title: "Open Camera",icon:  Icon(Icons.photo_camera, color: Colors.white,),),
  ];
  
  @override
  void initState() {
    super.initState();
    UserDetails.getUserId(context);
    _locationData = new LocationData();
    _locationData.getStateList().then((value) => setState((){stateList = value;}));
    userProfile = new Profile();

    UserDetails.loadUserProfile().then((value){
      setState(() {
        isProfileLoaded = true;
        userProfile = value;
        _emailTextController.text = userProfile.email;
        _phoneTextController.text = userProfile.phone;
        _studentNameTextController.text = UserDetails.firebaseUser.displayName;
      });
    });
  }

  @override
  Widget build(BuildContext context){
   return Scaffold(
     appBar: AppBar(
       leading: InkWell(
         onTap: () {
           Navigator.of(context).pop();
         },
         child: Icon(
           Icons.arrow_back, color: Font_Style.primaryColor, size: 24.0,),
       ),
       title: Text(
         "My Profile", style: Font_Style.productsans_Bold(null, 60),),
       centerTitle: true,
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
                     //image: new NetworkImage("https://firebasestorage.googleapis.com/v0/b/aegle-e153c.appspot.com/o/HomeTiles%2Faboutus.png?alt=media&token=cfc92220-6077-41ed-8e14-dc654c5e1fc"),
                     image: changedNow ? FileImage(_imageFile) : (FirebaseAuth.instance.currentUser.photoURL == null ? AssetImage("assets/userprofiledefault.png") : NetworkImage(FirebaseAuth.instance.currentUser.photoURL)),
                     fit: BoxFit.fill,
                     colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                   ),
                 ),
                 child: BackdropFilter(
                   filter: ImageFilter.blur(sigmaX: 5,),
                   child: Center(
                     child: InkWell(
                       onTap: () {
                         profilePhotoSheet(context);
                       },
                       child: Hero(
                         tag: 'display_pic',
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
                                       image: changedNow ? FileImage(_imageFile) : (FirebaseAuth.instance.currentUser.photoURL == null ? AssetImage("assets/userprofiledefault.png") : NetworkImage(FirebaseAuth.instance.currentUser.photoURL)),
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
                                     color: Colors.cyan[900]
                                 ),
                                 child: Center(
                                   child: Icon(Icons.edit,size: 12,color: Colors.white,),
                                 ),
                               ),
                             )
                           ],
                         ),
                       ),
                     ),
                   ),
                 )
             ),
             Expanded(
               child: Stack(
                 children: <Widget>[
                   Container(
                     height: MediaQuery.of(context).size.height,
                     width: MediaQuery.of(context).size.width,
                     padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 50.0.h),
                     child: SingleChildScrollView(
                       child: Column(
                         children: !isProfileLoaded || _locationData.states == null || _locationData.states.length == 0 ? [] : [
                           profileEntry("Email Address", false, _emailTextController, 45, TextInputType.emailAddress),
                           profileEntry("Student Name", true, _studentNameTextController, 30, TextInputType.text),
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
                               userProfile.sem,
                               "Select Semester",
                                   (String newValue) {
                                 setState(() {
                                   userProfile.sem = newValue;
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
                               userProfile.branch,
                               "Select Branch",
                                   (String newValue) {
                                 setState(() {
                                   userProfile.branch = newValue;
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
                               userProfile.state,
                               "Select State",
                                   (String newValue) {
                                 setState(() {
                                   userProfile.state = newValue;
                                   userProfile.dist = null;
                                 });
                               }
                           ),
                           profileDropDownEntry(
                               _locationData.getDistrict(userProfile.state)
                                   .map<DropdownMenuItem<String>>((String value) {
                                 return DropdownMenuItem<String>(
                                   value: value,
                                   child: Text(value),
                                 );
                               })
                                   .toList(),
                               userProfile.dist,
                               "Select District",
                                   (String newValue) {
                                 setState(() {
                                   userProfile.dist = newValue;
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
                         onPressed: () async {
                           print("update");
                           ////////////////////////////////////////////////////
                           if(_studentNameTextController.text != FirebaseAuth.instance.currentUser.displayName){
                             await FirebaseAuth.instance.currentUser.updateProfile(displayName: _studentNameTextController.text);
                           }

                           userProfile.email = _emailTextController.text;
                           userProfile.phone = _phoneTextController.text;
                           await UserDetails.updateUserProfile(userProfile);
                           formUpdateFlare(context);
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
        border: Border.all(color: userProfile.state == null && hint == "Select District" ? Font_Style.primaryColor.withOpacity(0.2) : Font_Style.secondaryColor, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonFormField<String>(
        value: dropdownValue,
        hint: Text("$hint", style: Font_Style.productsans_SemiBold(userProfile.state == null && hint == "Select District" ? Font_Style.primaryColor.withOpacity(0.2) : Font_Style.primaryColor.withOpacity(0.7), 45),),
        icon: Icon(Icons.arrow_drop_down, color: userProfile.state == null && hint == "Select District" ? Font_Style.primaryColor.withOpacity(0.2) : Font_Style.secondaryColor, size: 24.0,),
        iconSize: 24,
        elevation: 16,
        style: Font_Style.productsans_SemiBold(userProfile.state == null && hint == "Select District" ? Font_Style.primaryColor.withOpacity(0.2) : null, 45),
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

  void formUpdateFlare(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Profile updated successfully",
            style: Font_Style.productsans_Bold(null, 50),
          ),
          contentPadding: EdgeInsets.all(0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: MediaQuery.of(context).size.width / 4,
                width: MediaQuery.of(context).size.width / 4,
                child: FlareActor(
                    "assets/form agreed anim.flr",
                    alignment: Alignment.center,
                    fit: BoxFit.fill,
                    animation: "update",
                    snapToEnd: true,
                ),
              ),
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Ok',
                style: Font_Style.productsans_SemiBold(null, 50)
              ),
            ),
          ],
        );
      },
    );
  }

  void profilePhotoSheet(context){
    showModalBottomSheet(
        context: (context),
        enableDrag: true,
        isDismissible: true,
        builder: (context) {
          return Container(
            color: Color(0XFF737373),
            child: Container(
              decoration: BoxDecoration(
                  color: Font_Style.primaryColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(60),
                      topLeft: Radius.circular(60))),
              padding: EdgeInsets.only(top: 10.h, left: 43.w, right: 43.w),
              height: 400.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 35,
                    height: 3,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Spacer(flex: 30,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                        profilePhotoSelectList.length,
                            (index) => Container(
                          padding: EdgeInsets.only(bottom: 50.h),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              if(index == 0) {
                                _getAndUploadImage(0);
                              }
                              else if(index == 1) {
                                _getAndUploadImage(1);
                              }
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    profilePhotoSelectList[index].icon,
                                    SizedBox(width: 40.0.w,),
                                    Text(
                                      profilePhotoSelectList[index].title,
                                      style: Font_Style.productsans_SemiBold(Colors.white, 54.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                  Spacer(flex: 20,),
                ],
              ),
            ),
          );
        });
  }
  
  Future _getAndUploadImage(int type) async {
    var pickedFile;
    if(type == 0) {
      pickedFile = await _imagePicker.getImage(source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 100
      );
    }
    else{
      pickedFile = await _imagePicker.getImage(source: ImageSource.camera);
    }
    setState(() {
      if(pickedFile != null) {
        _imageFile = File(pickedFile.path);
        _cropImage();
        print(_imageFile);
      }
      else {
        print("image picker error");
      }
    });
    Reference ref =FirebaseStorage.instance.ref('Profile/${FirebaseAuth.instance.currentUser.uid}');
    ref.putFile(_imageFile).whenComplete(() => updateOnDB(ref));
    print('File Uploaded');
  }

  void updateOnDB(Reference ref) async {
    String url = await ref.getDownloadURL();
    await FirebaseAuth.instance.currentUser.updateProfile(photoURL: url);
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ]
            : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings());
    if (croppedFile != null) {
      _imageFile = croppedFile;
      setState(() {
        changedNow = true;
      });
      //_clearImage();
    }
    else {  
      print("Error in cropping");
    }
  }

  void _clearImage() {
    _imageFile = null;
    setState(() {
      changedNow = false;
    });
  }
}

class ProfilePhotoSelectType {
  final String title;
  final Widget icon;
  ProfilePhotoSelectType({this.title,this.icon});
}