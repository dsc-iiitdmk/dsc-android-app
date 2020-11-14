

import 'package:dsc_iiitdmkl/ThemeData/fontstyle.dart';
import 'package:dsc_iiitdmkl/screens/home_package/home_botnav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventsBotNav extends StatefulWidget{

  _EventsBotNavState createState() => _EventsBotNavState();
}

class _EventsBotNavState extends State<EventsBotNav> with TickerProviderStateMixin{

  @override
  void initState() {
    // TODO: implement initState

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage("assets/logo.png"), width: 40, height: 40, fit: BoxFit.contain,),
            SizedBox(width: 20,),
            Text("DSC IIITDM Kurnool", style: Font_Style.productsans_Bold(Font_Style.primaryColor.withOpacity(0.7), 50,), ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.grey[50],
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Text("Events", style: TextStyle(color: Colors.black, fontSize: 28, fontFamily: "ProductSans", fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                SizedBox(height: 20,),
                Text("Google collaborates with university students who are passionate about growing developer communities. Developer Student Club powered by Google Developers is an initiative to grow their knowledge on developer technologies and more through peer to peer workshops and events, and gain relevant industry experience.",
                  textAlign: TextAlign.left,
                  style:  TextStyle(color: Colors.black, fontSize: 16, fontFamily: "ProductSans", fontWeight: FontWeight.normal),),
                SizedBox(height: 20,),
                Card(
                  elevation: 5,
                  margin: EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    alignment: Alignment.center,
                    child: Text("AI/ML COMPETITIONS AND QUIZ", style: TextStyle(color: Colors.white, fontSize: 26, fontFamily: "ProductSans", fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(Colors.black.withAlpha(50), BlendMode.srcATop),
                        fit: BoxFit.cover,
                        image: Image.network("https://firebasestorage.googleapis.com/v0/b/aegle-e153c.appspot.com/o/HomeTiles%2Faboutus.png?alt=media&token=cfc92220-6077-41ed-8e14-dc654c5e1fc4", width: MediaQuery.of(context).size.width, height: 200, fit: BoxFit.cover, colorBlendMode: BlendMode.srcIn, color: Colors.black,).image  ,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        )

      ),
    );
  }


}