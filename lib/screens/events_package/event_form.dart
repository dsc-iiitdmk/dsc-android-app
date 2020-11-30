import 'package:dsc_iiitdmkl/ThemeData/fontstyle.dart';
import 'package:dsc_iiitdmkl/screens/events_package/events_botnav.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dsc_iiitdmkl/Backend/DataClasses/Events.dart';

class EventForm extends StatefulWidget {
  final Events event;
  EventForm({this.event});

  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  @override
  Widget build(BuildContext context) {
    final EventForm eventFormArgs = ModalRoute.of(context).settings.arguments;
    print(eventFormArgs.event);

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
          "Event Registration", style: Font_Style.productsans_Bold(null, 60),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: new NetworkImage(eventFormArgs.event.img),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 50.0.h),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          eventFormCardView(eventFormArgs.event),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }

  Widget eventFormCardView(Events event){
    return Card(
      elevation: 7.0,
      margin: EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 20.0.h),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 25.0.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: <Widget>[
            Text(event.name, textDirection: TextDirection.ltr, textAlign: TextAlign.center, style: Font_Style.productsans_Bold_Underline(null, 55),),
            SizedBox(height: 30.0.h,),
            Text(event.desc,textDirection: TextDirection.ltr, textAlign: TextAlign.center, style: Font_Style.productsans_medium(null, 45),),
            SizedBox(height: 30.0.h,),
            Text("Start Time : ${DateTime.fromMillisecondsSinceEpoch(event.startTime).toString().substring(12,16)}, ${DateTime.fromMillisecondsSinceEpoch(event.startTime).toString().substring(0,10)}",textDirection: TextDirection.ltr, textAlign: TextAlign.center, style: Font_Style.productsans_SemiBold(Colors.cyan, 42),),
            SizedBox(height: 20.0.h,),
            Text("End Time : ${DateTime.fromMillisecondsSinceEpoch(event.endTime).toString().substring(12,16)}, ${DateTime.fromMillisecondsSinceEpoch(event.endTime).toString().substring(0,10)}",textDirection: TextDirection.ltr, textAlign: TextAlign.center, style: Font_Style.productsans_SemiBold(Colors.cyan, 42),),
          ],
        ),
      ),
    );
  }
}
