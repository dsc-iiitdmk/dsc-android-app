import 'dart:collection';

import 'package:dsc_iiitdmkl/Backend/ChangeNotifiers/form_data.dart';
import 'package:dsc_iiitdmkl/Backend/DataClasses/Events.dart';
import 'package:dsc_iiitdmkl/Backend/DataClasses/FormResponse.dart';
import 'package:dsc_iiitdmkl/screens/events_package/event_form.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dsc_iiitdmkl/ThemeData/fontstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyRegistration extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyRegistrationState();
  }
}

class MyRegistrationState extends State<MyRegistration>{
  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    Provider.of<FormData_Data>(context);

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
            child: Icon(Icons.arrow_back, size: 24.0, color: Font_Style.primaryColor,)),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("My Registrations", textAlign: TextAlign.left, style: Font_Style.productsans_Bold(null, 60)),
      ),
      body: SafeArea(
          child: ListView.builder(itemBuilder: (context, index){
            return ResponseCard(Provider.of<FormData_Data>(context).myForms.values.toList().elementAt(index));
          }, scrollDirection: Axis.vertical, itemCount: Provider.of<FormData_Data>(context).myForms.values.toList().length, padding: EdgeInsets.symmetric(vertical: 10),)
      ),
    );
  }

  Widget ResponseCard(FormResponse response){
    return InkWell(
      onTap: (){
        Events event = new Events();
        event.formID = response.formID;
        event.img = "";
        HashMap<String, dynamic> data = new HashMap();
        data.putIfAbsent("event", () => event);
        data.putIfAbsent("responseTime", () => response.time);
        data.putIfAbsent("edit", () => false);
        //Navigator.pushNamed(context, "event_form", arguments: data);
        Navigator.push(context,
          MaterialPageRoute(builder: (context) =>
              EventForm(data: data)),);
      },
      child: Card(
          elevation: 3.0,
          margin: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10,),
                  Text(response.title, style: Font_Style.productsans_Bold(Colors.black, 60), textAlign: TextAlign.center,),
                  SizedBox(height: 5,),
                  Text(getStringFromTime(response.time), style: Font_Style.productsans_medium(Colors.grey[800], 45), textAlign: TextAlign.center,),
                  SizedBox(height: 5,),
                ],
              )
          )
      ),
    );
  }

  String getStringFromTime(int time){
    DateTime date = DateTime.fromMillisecondsSinceEpoch(time);
    return date.toString();
  }

}