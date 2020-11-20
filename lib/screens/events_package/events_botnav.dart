import 'package:dsc_iiitdmkl/ThemeData/fontstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventsBotNav extends StatefulWidget{
  _EventsBotNavState createState() => _EventsBotNavState();
}

class _EventsBotNavState extends State<EventsBotNav> with SingleTickerProviderStateMixin{

  TabController _eventsTabController;
  var _height, _width;
  
  @override
  void initState() {
    setState(() {
      _eventsTabController = TabController(length: 3, vsync: this, initialIndex: 1);
    });
    super.initState();
  }

  /*
  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage("assets/logo.png"), width: 40, height: 40, fit: BoxFit.contain,),
            SizedBox(width: 20,),
            Text("DSC IIITDM Kurnool", style: Font_Style.productsans_Bold(Font_Style.primaryColor.withOpacity(0.7), 50,), ),
          ],
        ),
   */
  //upcoming, ongoing, past
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Events", textAlign: TextAlign.left, style: Font_Style.productsans_Bold(null, 68)),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 120.0.h,
                child: Center(
                  child: TabBar(
                    controller: _eventsTabController,
                    indicatorColor: Colors.cyan[400],
                    //indicatorPadding: EdgeInsets.symmetric(horizontal: 38.0.w),
                    labelPadding: EdgeInsets.only(bottom: 7.0.h,),
                    unselectedLabelColor: Font_Style.secondaryColor.withOpacity(0.7),
                    labelColor: Colors.cyan[900],
                    labelStyle: Font_Style.productsans_Bold(Font_Style.secondaryColor, 60),
                    unselectedLabelStyle: Font_Style.productsans_SemiBold(Font_Style.secondaryColor, 58),
                    onTap: (int x) {
                      _eventsTabController.index = x;
                    },
                    tabs: <Widget>[
                      Text("Upcoming", textAlign: TextAlign.center, textDirection: TextDirection.ltr, overflow: TextOverflow.visible,),
                      Text("Ongoing", textAlign: TextAlign.center, textDirection: TextDirection.ltr, overflow: TextOverflow.visible,),
                      Text("Past", textAlign: TextAlign.center, textDirection: TextDirection.ltr, overflow: TextOverflow.visible,),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w,),
                  child: TabBarView(
                    controller: _eventsTabController,
                    children: <Widget>[
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: 5,
                          itemBuilder: (context, i) {
                            return _eventsItem();
                          },
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: 5,
                          itemBuilder: (context, i) {
                            return _eventsItem();
                          },
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: 5,
                          itemBuilder: (context, i) {
                            return _eventsItem();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  Widget _eventsItem() {
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: _height / 5,
        alignment: Alignment.center,
        child: Text("AI/ML COMPETITIONS AND QUIZ", style: TextStyle(color: Colors.white, fontSize: 26, fontFamily: "ProductSans", fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black.withAlpha(50), BlendMode.srcATop),
            fit: BoxFit.cover,
            image: Image.network("4https://firebasestorage.googleapis.com/v0/b/aegle-e153c.appspot.com/o/HomeTiles%2Faboutus.png?alt=media&token=cfc92220-6077-41ed-8e14-dc654c5e1fc", width: MediaQuery.of(context).size.width, height: 200, fit: BoxFit.cover, colorBlendMode: BlendMode.srcIn, color: Colors.black,).image  ,
          ),
        ),
      ),
    );
  }
}