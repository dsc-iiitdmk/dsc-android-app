import 'dart:collection';

import 'package:dsc_iiitdmkl/Backend/ChangeNotifiers/form_data.dart';
import 'package:dsc_iiitdmkl/Backend/DataClasses/FormData.dart';
import 'package:dsc_iiitdmkl/ThemeData/fontstyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dsc_iiitdmkl/Backend/DataClasses/Events.dart';
import 'package:provider/provider.dart';

class EventForm extends StatefulWidget {

  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final HashMap<String, dynamic> eventFormArgs = ModalRoute.of(context).settings.arguments;
    final Events eventData = eventFormArgs['event'];
    Provider.of<FormData_Data>(context).loadForm(eventData.formID);

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
                      image: new NetworkImage(Provider.of<FormData_Data>(context).formData != null ? Provider.of<FormData_Data>(context).formData.topImage : eventData.img),
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
                          Provider.of<FormData_Data>(context).formData != null ? commonEventFormCardView(eventData, Provider.of<FormData_Data>(context).formData,  eventFormArgs['edit'], eventFormArgs['responseTime']) : SizedBox(height: 0,),
                          Provider.of<FormData_Data>(context).formData != null ? dynamicFormCardView(Provider.of<FormData_Data>(context).formData, eventFormArgs['edit']) : SizedBox(height: 0,),
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

  Widget commonEventFormCardView(Events event, FormData data, bool edit, int responseTime){
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
            Text(data.title, textDirection: TextDirection.ltr, textAlign: TextAlign.center, style: Font_Style.productsans_Bold_Underline(null, 55),),
            SizedBox(height: 50.0.h,),
            Column(
              children:  !edit ? [
                Text("Submitted On : ${DateTime.fromMillisecondsSinceEpoch(responseTime).toString()}",textDirection: TextDirection.ltr, textAlign: TextAlign.center, style: Font_Style.productsans_SemiBold(Colors.teal, 42),),
              ] : [
                Text(data.desc,textDirection: TextDirection.ltr, textAlign: TextAlign.center, style: Font_Style.productsans_medium(null, 45),),
                SizedBox(height: 30.0.h,),
                Text("Start Time : ${DateTime.fromMillisecondsSinceEpoch(event.startTime).toString().substring(12,16)}, ${DateTime.fromMillisecondsSinceEpoch(event.startTime).toString().substring(0,10)}",textDirection: TextDirection.ltr, textAlign: TextAlign.center, style: Font_Style.productsans_SemiBold(Colors.teal, 42),),
                SizedBox(height: 20.0.h,),
                Text("End Time : ${DateTime.fromMillisecondsSinceEpoch(event.endTime).toString().substring(12,16)}, ${DateTime.fromMillisecondsSinceEpoch(event.endTime).toString().substring(0,10)}",textDirection: TextDirection.ltr, textAlign: TextAlign.center, style: Font_Style.productsans_SemiBold(Colors.teal, 42),),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget dynamicFormCardView(FormData data, bool isEditable) {
    DateTime _currentTime = new DateTime.now();
    return Card(
      elevation: 7.0,
      margin: EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 20.0.h),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Form(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 25.0.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            children: <Widget>[
              Text("Registration Form", style: Font_Style.productsans_SemiBold_underline(Colors.blue, 56),),
              SizedBox(height: 80.0.h,),
              Column(
                children: getFormFields(data, isEditable),
              ),
              isEditable ? RaisedButton(
                onPressed: _submitRegistrationForm,
                textColor: Colors.white,
                color: isFormValid() ? Colors.teal : Colors.grey,
                padding: EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 55.0),
                child: Text(
                  "Submit",
                  style: Font_Style.productsans_Bold(Colors.white, 52),
                ),
              ) : Container(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getFormFields(FormData data, bool isEditable){
    return data.entries.map<Widget>((e){
      int index = Provider.of<FormData_Data>(context, listen: false).formData.entries.indexOf(e);
      if(e.type == FormEntry.ENTRY_TEXT || e.type == FormEntry.ENTRY_NUMBER){
        return Widget_FormEntryText(e, Provider.of<FormData_Data>(context, listen: false).formData.responses.elementAt(index), isEditable, (val){
          Provider.of<FormData_Data>(context, listen: false).formData.responses.removeAt(index);
          Provider.of<FormData_Data>(context, listen: false).formData.responses.insert(index, val);
          print('Text or Number Val : ' + val.toString());
        });
      }else if(e.type == FormEntry.ENTRY_CHECKBOX ){
        return Widget_FormEntryCheckGroup(e, Provider.of<FormData_Data>(context, listen: false).formData.responses.elementAt(index),isEditable, (val){
          Provider.of<FormData_Data>(context, listen: false).formData.responses.removeAt(index);
          Provider.of<FormData_Data>(context, listen: false).formData.responses.insert(index, val);
          print('Check Val : ' + val.toString());
          setState(() {});
        });
      }else if(e.type == FormEntry.ENTRY_RADIO){
        return Widget_FormEntryRadioGroup(e, Provider.of<FormData_Data>(context, listen: false).formData.responses.elementAt(index), isEditable, (val){
          Provider.of<FormData_Data>(context, listen: false).formData.responses.removeAt(index);
          Provider.of<FormData_Data>(context, listen: false).formData.responses.insert(index, val);
          print('Radio Val : ' + val.toString());
          setState(() {});
        });
      }
    }).toList();
  }

  // common for text and number
  Widget Widget_FormEntryText(FormEntry entry, String defVal, bool isEnabled, Function(dynamic) listener){
    TextEditingController controller = new TextEditingController();
    controller.text = defVal;

    controller.addListener(() {
      listener(controller.text);
    });

    return Column(
      children: [
        SizedBox(height: 20,),
        Text(entry.title, style: Font_Style.productsans_medium(Colors.black, 45),),
        SizedBox(height: 10,),
        TextFormField(
          enabled: isEnabled,
          scrollPadding: EdgeInsets.all(25),
          maxLength: entry.inputLength,
          maxLines: 5,
          minLines: 1,
          controller: controller,
          decoration: Font_Style.setLabelAllBorders(null, null, null, context),
          keyboardType: entry.type == FormEntry.ENTRY_TEXT ? TextInputType.text : TextInputType.number,
          cursorColor: Font_Style.secondaryColor.withOpacity(0.3),
          style:  Font_Style.textfield_style(),
        ),
        Divider(),
      ],
    );
  }

  Widget Widget_FormEntryCheckGroup(FormEntry entry, dynamic defVal, bool isEnabled, Function(dynamic) listener){
    List<bool> values = new List.filled(entry.checks.length, false, growable: true);
    if(defVal != null) values = List<bool>.from(defVal, growable: true);

    return Column(
      children: [
        SizedBox(height: 20,),
        Text(entry.title, style: Font_Style.productsans_medium(Colors.black, 45),),
        SizedBox(height: 10,),
        Column(
          children: entry.checks.map<Widget>((e){
            return CheckboxListTile(
              selected: values.elementAt(entry.checks.indexOf(e)),
              title: Text(e, style: Font_Style.productsans_medium(null, 48),),
              value: values.elementAt(entry.checks.indexOf(e)),
              onChanged: (newValue) {
                // to disable when using view mode
                if(!isEnabled) return;

                values.removeAt(entry.checks.indexOf(e));
                values.insert(entry.checks.indexOf(e), newValue);
                print('Changing Check');
                listener(values);
              },
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Colors.teal,
              checkColor: Colors.white,
            );
          }).toList(),
        ),
        Divider(),
      ],
    );
  }

  Widget Widget_FormEntryRadioGroup(FormEntry entry, dynamic defVal, bool isEnabled, Function(dynamic) listener){

    var groupVal = defVal;

    return Column(
      children: [
        SizedBox(height: 20,),
        Text(entry.title, style: Font_Style.productsans_medium(Colors.black, 45),),
        SizedBox(height: 10,),
        Column(
          children: entry.radios.map<Widget>((e){
            return RadioListTile(
              value: e,
              groupValue: groupVal,
              onChanged: (val) {
                // to disable when using view mode
                if(!isEnabled) return;

                groupVal = val;
                listener(groupVal);
              },
              activeColor: Colors.teal,
              title: Text(e),
            );
          }).toList(),
        ),
        Divider(),
      ],
    );
  }


  //TODO ADD DIALOGS WITH LOADERS AND SUCCESS AND FAIL INDICATORS
  void _submitRegistrationForm() {
    if(isFormValid()){
      HashMap<String, dynamic> dataToSave = new HashMap();
      dataToSave.putIfAbsent("time", () => DateTime.now().millisecondsSinceEpoch);
      dataToSave.putIfAbsent("title", () => Provider.of<FormData_Data>(context, listen: false).formData.title);
      dataToSave.putIfAbsent("formID", () => Provider.of<FormData_Data>(context, listen: false).formData.formID);
      dataToSave.putIfAbsent("responses", () => Provider.of<FormData_Data>(context, listen: false).formData.responses);
      print('saving!!!');
      FirebaseDatabase.instance.reference()
          .child("response/${FirebaseAuth.instance.currentUser.uid}/${dataToSave['formID']}/")
          .set(dataToSave)
      .then((value){
        print('Success!!!!');
        Navigator.of(context).pop();
      })
      .catchError((err){
        print('Error Saving Response! : ' + err.toString());
      });
    }
  }

  // check for mandate fields
  bool isFormValid(){
    List<FormEntry> entries = Provider.of<FormData_Data>(context, listen: false).formData.entries;
    List<dynamic> responses = Provider.of<FormData_Data>(context, listen: false).formData.responses;
    bool mandateFullfilled = true;
    for(FormEntry entry in entries){
      if(entry.isMandate){
        dynamic response =  responses.elementAt(entries.indexOf(entry));
        if(response == null || response == "" || response == []){
          mandateFullfilled = false;
          break;
        }
      }
    }
    return mandateFullfilled;
  }
}

abstract class OnFormFieldValueChange{
  void OnValueChange(dynamic value);
}