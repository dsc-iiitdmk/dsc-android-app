import 'package:dsc_iiitdmkl/ThemeData/fontstyle.dart';
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

  final _registrationFormKey = GlobalKey<FormState>();

  TextEditingController _dynamicTextController = new TextEditingController();
  TextEditingController _dynamicNumberController = new TextEditingController();
  bool checkedValue = true;
  int groupValue = 0;
  RangeValues _currentRangeValues = const RangeValues(1, 3);
  
  @override
  Widget build(BuildContext context) {
    final EventForm eventFormArgs = ModalRoute.of(context).settings.arguments;

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
                    padding: EdgeInsets.only(left: 15.0.w, right: 15.0.w, top: 40.0.h, bottom: 8.0.h),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          commonEventFormCardView(eventFormArgs.event),
                          dynamicFormCardView(),
                          SizedBox(height: 60.0.h,),
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

  Widget commonEventFormCardView(Events event){
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
            SizedBox(height: 50.0.h,),
            Text(event.desc,textDirection: TextDirection.ltr, textAlign: TextAlign.center, style: Font_Style.productsans_medium(null, 45),),
            SizedBox(height: 30.0.h,),
            Text("Start Time : ${DateTime.fromMillisecondsSinceEpoch(event.startTime).toString().substring(12,16)}, ${DateTime.fromMillisecondsSinceEpoch(event.startTime).toString().substring(0,10)}",textDirection: TextDirection.ltr, textAlign: TextAlign.center, style: Font_Style.productsans_SemiBold(Colors.teal, 42),),
            SizedBox(height: 20.0.h,),
            Text("End Time : ${DateTime.fromMillisecondsSinceEpoch(event.endTime).toString().substring(12,16)}, ${DateTime.fromMillisecondsSinceEpoch(event.endTime).toString().substring(0,10)}",textDirection: TextDirection.ltr, textAlign: TextAlign.center, style: Font_Style.productsans_SemiBold(Colors.teal, 42),),
          ],
        ),
      ),
    );
  }

  Widget dynamicFormCardView() {
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
        child: Form(
          key: _registrationFormKey,
          child: Column(
            children: <Widget>[
              Text("Registration Form", style: Font_Style.productsans_SemiBold_underline(Colors.blue, 56),),
              SizedBox(height: 60.0.h,),
              TextFormField(
                validator: (val){
                  return val.length <= 10 ? "Too short" : "";
                },
                scrollPadding: EdgeInsets.all(25),
                maxLines: 5,
                minLines: 1,
                controller: _dynamicTextController,
                decoration: Font_Style.setLabelAllBorders("Enter Details", null, null, context),
                keyboardType: TextInputType.text,
                cursorColor: Font_Style.secondaryColor.withOpacity(0.3),
                style:  Font_Style.textfield_style(),
              ),
              SizedBox(height: 40.0.h,),
              TextFormField(
                validator: (val){
                  return val.length <= 2 ? "Too short" : "";
                },
                scrollPadding: EdgeInsets.all(25),
                maxLines: 2,
                minLines: 1,
                controller: _dynamicNumberController,
                decoration: Font_Style.setLabelAllBorders("Enter Number", null, null, context),
                keyboardType: TextInputType.number,
                cursorColor: Font_Style.secondaryColor.withOpacity(0.3),
                style:  Font_Style.textfield_style(),
              ),
              SizedBox(height: 40.0.h,),
              CheckboxListTile(
                title: Text("Title Text", style: Font_Style.productsans_medium(null, 48),),
                value: checkedValue,
                onChanged: (newValue) {
                  setState(() {
                    checkedValue = newValue;
                  });
                },
                controlAffinity: ListTileControlAffinity.trailing,
                activeColor: Colors.teal,
                checkColor: Colors.white,
              ),
              Divider(),
              SizedBox(height: 20.0.h,),
              Align(
                alignment: Alignment.centerLeft,
                  child: Text("Select Any One :", textAlign: TextAlign.left, textDirection: TextDirection.ltr, overflow: TextOverflow.clip, style: Font_Style.productsans_SemiBold_underline(Colors.blue, 46),)),
              SizedBox(height: 20.0.h,),
              ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 3,
                itemBuilder: (context, i) {
                  return _radioButton("Item ${i}", i);
                },
              ),
              Divider(),
              SizedBox(height: 20.0.h,),
              Align(
                alignment: Alignment.centerLeft,
                  child: Text("Select Range :", textAlign: TextAlign.left, textDirection: TextDirection.ltr, overflow: TextOverflow.clip, style: Font_Style.productsans_SemiBold_underline(Colors.blue, 46),)),
              SizedBox(height: 20.0.h,),
              RangeSlider(
                min: 1,
                max: 5,
                divisions: 5,
                activeColor: Colors.teal,
                values: _currentRangeValues,
                labels: RangeLabels(
                  _currentRangeValues.start.round().toString(),
                  _currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues = values;
                  });
                },
              ),
              SizedBox(height: 80.0.h,),
              RaisedButton(
                onPressed: () {
                  if(_registrationFormKey.currentState.validate()) {
                    print("Submit");
                  }
                },
                textColor: Colors.white,
                color: Colors.teal,
                padding: EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 55.0),
                child: Text(
                  "Submit",
                  style: Font_Style.productsans_Bold(Colors.white, 52),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _radioButton(String title, int value) {
    return RadioListTile(
      value: value,
      groupValue: groupValue,
      onChanged: (val) {
        setState(() {
          groupValue = val;
        });
      },
      activeColor: Colors.teal,
      title: Text(title),
    );
  }
}
