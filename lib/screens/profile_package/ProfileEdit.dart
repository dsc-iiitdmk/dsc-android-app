
import 'dart:ui';

import 'package:dsc_iiitdmkl/Data/LocationData.dart';
import 'package:dsc_iiitdmkl/ThemeData/fontstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileEdit extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProfileEdit_State();
  }
}

class ProfileEdit_State extends State<ProfileEdit>{

  String dropdown_selectedYear = null;
  String dropdown_selectedBranch = null;
  String dropdown_selectedState = null;
  String dropdown_selectedDist = null;
  LocationData _locationData;
  List<String> stateList = new List<String>();

  @override
  void initState() {
    // TODO: implement initState
    _locationData = new LocationData();
    _locationData.getStateList().then((value) => setState((){stateList = value;}));
  }

  @override
  Widget build(BuildContext context){
   return Scaffold(
     body: SafeArea(
       child: Container(
         height: MediaQuery.of(context).size.height,
         color: Colors.white,
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment:  MainAxisAlignment.start,
           children: [
             Container(
                 decoration: BoxDecoration(
                   image: DecorationImage(
                     image: new NetworkImage("https://firebasestorage.googleapis.com/v0/b/aegle-e153c.appspot.com/o/HomeTiles%2Faboutus.png?alt=media&token=cfc92220-6077-41ed-8e14-dc654c5e1fc"),
                     fit: BoxFit.fill,
                     colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                   ),
                 ),
                 child: BackdropFilter(
                   filter: ImageFilter.blur(sigmaX: 5, ),
                   child: Column(
                     children: [
                       SizedBox(height: 20,),
                       Text("EDIT PROFILE", style: Font_Style.productsans_Bold(Colors.white, 50), textAlign: TextAlign.center, ),
                       SizedBox(height: 40,),
                       Stack(
                         children: <Widget>[
                           ClipRRect(
                             borderRadius: BorderRadius.circular(50),
                             child: Container(
                               color: Colors.white,
                               child: Image.network("https://firebasestorage.googleapis.com/v0/b/aegle-e153c.appspot.com/o/HomeTiles%2Faboutus.png?alt=media&token=cfc92220-6077-41ed-8e14-dc654c5e1fc", fit: BoxFit.fill , height: 100, width: 100,),
                             ),
                           ),
                           Padding(
                             padding: EdgeInsets.only(left: 75,top: 75),
                             child: Container(
                               width: 25,
                               height: 25,
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
                       SizedBox(height: 5,),
                       Container(
                         padding: EdgeInsets.symmetric(horizontal: 40),
                         child: TextField(
                           cursorColor: Colors.white,
                           controller: null,
                           style: Font_Style.productsans_medium(Colors.white, 55),
                           decoration: InputDecoration(
                             enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)),
                             focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)),
                           ),
                         ),
                       ),
                       SizedBox(height: 20,),
                     ],
                   ),
                 )
             ),
             SizedBox(height: 10,),
             Expanded(
               flex: 1,
               child: SingleChildScrollView(
                 child: Column(
                   children: [
                     ProfileEntry("PHONE", null),
                     ProfileDropDownEntry(
                       "YEAR",
                         <String>['First', 'Second', 'Third', 'Fourth']
                             .map<DropdownMenuItem<String>>((String value) {
                           return DropdownMenuItem<String>(
                             value: value,
                             child: Text(value),
                           );
                         })
                             .toList(),
                       dropdown_selectedYear,
                             (String newValue) {
                           setState(() {
                             dropdown_selectedYear = newValue;
                           });
                         }
                     ),
                     ProfileDropDownEntry(
                         "BRANCH",
                         <String>['Computer Science', 'Electronics & Communications', 'Mechanical', 'Others']
                             .map<DropdownMenuItem<String>>((String value) {
                           return DropdownMenuItem<String>(
                             value: value,
                             child: Text(value),
                           );
                         })
                             .toList(),
                         dropdown_selectedBranch,
                             (String newValue) {
                           setState(() {
                             dropdown_selectedBranch = newValue;
                           });
                         }
                     ),
                     ProfileDropDownEntry(
                         "STATE",
                         stateList
                             .map<DropdownMenuItem<String>>((String value) {
                           return DropdownMenuItem<String>(
                             value: value,
                             child: Text(value),
                           );
                         })
                             .toList(),
                         dropdown_selectedState,
                             (String newValue) {
                           setState(() {
                             dropdown_selectedState = newValue;
                             dropdown_selectedDist = null;
                           });
                         }
                     ),
                     ProfileDropDownEntry(
                         "DISTRICT",
                         _locationData.getDistrict(dropdown_selectedState)
                             .map<DropdownMenuItem<String>>((String value) {
                           return DropdownMenuItem<String>(
                             value: value,
                             child: Text(value),
                           );
                         })
                             .toList(),
                         dropdown_selectedDist,
                             (String newValue) {
                           setState(() {
                             dropdown_selectedDist = newValue;
                           });
                         }
                     ),
                     Container(
                       width: MediaQuery.of(context).size.width / 2,
                       child: FlatButton(onPressed: null, child: Container(
                         alignment: Alignment.center,
                         padding: EdgeInsets.symmetric(vertical: 10),
                         decoration: BoxDecoration(
                           color: Colors.teal[800],
                           borderRadius: BorderRadius.circular(5),
                         ),
                         child: Text("UPDATE", style: Font_Style.productsans_Bold(Colors.white, 40),),
                       )),
                     ),
                     SizedBox(height: 20,),
                   ],
                 ),
               ),
             ),
             SizedBox(height: 10,),
           ],
         ),
       ),
     ),
   );
  }

  Widget ProfileDropDownEntry(String title, List<DropdownMenuItem<String>> items, String dropdownValue,Function(String) onChange ){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Font_Style.productsans_medium(Colors.grey[800], 40),),
          SizedBox(height: 5,),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[600], width: 2),
              borderRadius: BorderRadius.circular(5),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.width / 7,
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: Font_Style.productsans_Light(Colors.grey[900], 60),
              isExpanded: true,
              onChanged: onChange,
              items: items,
            ),
          ),
          SizedBox(height: 20,),

        ],
      ),
    );
  }

  Widget ProfileEntry(String title, TextEditingController controller){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Font_Style.productsans_medium(Colors.grey[800], 40),),
          SizedBox(height: 5,),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.width / 7,
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color:  Colors.grey[600]), borderRadius: BorderRadius.circular(5),),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.black), borderRadius: BorderRadius.circular(5),),
              ),
              controller: controller,
              style: Font_Style.productsans_Light(Colors.grey[900], 60),
            ),
          ),
          SizedBox(height: 20,),

        ],
      ),
    );
  }
}