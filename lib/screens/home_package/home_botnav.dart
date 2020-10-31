import 'package:dsc_iiitdmkl/ThemeData/fontstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeBotNav extends StatefulWidget {
  @override
  _HomeBotNavState createState() => _HomeBotNavState();
}

class _HomeBotNavState extends State<HomeBotNav> with TickerProviderStateMixin {
  Animation<int> _totalCharacterCount;
  AnimationController _totalTextController;

  String _totalString = "Welcome to Developer Student Club IIITDM Kurnool";

  @override
  void initState() {
    super.initState();
    _totalTextController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );
    setState(() {
      _totalCharacterCount = StepTween(begin: 0, end: _totalString.length)
        .animate(
        CurvedAnimation(parent: _totalTextController, curve: Curves.easeIn)
      );
      _totalTextController.forward();
    });
  }

  @override
  void dispose() {
    _totalTextController.dispose();
    super.dispose();
  }

  launchAnyMap({String lat = "17.3850", String long = "78.4867"}) async {
    var mapSchema = 'geo:$lat,$long';
    if (await canLaunch(mapSchema)) {
      await launch(mapSchema);
    } else {
      throw 'Could not launch $mapSchema';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey[100],
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      color: Colors.blue,
                      height: MediaQuery.of(context).size.height / 3 - 70.0.h,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              width: 320.0.w,
                              height: 120.0.h,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage("assets/logo.png")
                                  )
                              )
                          ),
                          SizedBox(height: 20.0.h,),
                          _totalCharacterCount == null
                              ? SizedBox(
                            width: MediaQuery.of(context).size.width - 250.0.w,
                            child: Text(_totalString, textDirection: TextDirection.ltr, textAlign: TextAlign.center, style: Font_Style.productsans_Bold(Colors.white, 50,)))
                              : AnimatedBuilder(
                            animation: _totalCharacterCount,
                            builder: (BuildContext context, Widget child) {
                              String _displayText = _totalString.substring(0, _totalCharacterCount.value);
                              return SizedBox(
                                width: MediaQuery.of(context).size.width - 250.0.w,
                                  child: Text(_displayText, textDirection: TextDirection.ltr, textAlign: TextAlign.center, style: Font_Style.productsans_Bold(Colors.white, 50,)));
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(22.0.h),
                      child: Container(
                          width: 180.0.w,
                          height: 180.0.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: AssetImage("assets/iiitdmk-logo.png")
                              )
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0.h,),
                Card(
                  elevation: 7.0,
                  margin: EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 20.0.h),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 70.0.w,
                    padding: EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 25.0.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                        /*gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 21,236,229),
                            Color.fromARGB(255, 25,178,238),
                          ],
                        )*/
                    ),
                    child: Column(
                      children: <Widget>[
                        Text("About The Program", style: Font_Style.productsans_Bold(null, 55),),
                        SizedBox(height: 20.0.h,),
                        Text("Developer Student Club powered by Google developers "
                            "is an initiative to grow their knowledge on "
                            "developer technologies and more "
                            "through peer to peer workshops and events and gain "
                            "relevant industry experience."
                            "Google collaborates with university students who are "
                            "passionate about growing developer communities.", textAlign: TextAlign.center, style: Font_Style.productsans_medium(null, 45),),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 7.0,
                  margin: EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 20.0.h),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 70.0.w,
                    padding: EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 25.0.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        /*gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 21,236,229),
                            Color.fromARGB(255, 25,178,238),
                          ],
                        )*/
                    ),
                    child: Column(
                      children: <Widget>[
                        Text("What We Do At DSC IIITDMKL", style: Font_Style.productsans_Bold(null, 55),),
                        SizedBox(height: 20.0.h,),
                        Text("Developer Student Club, IIITDM Kurnool is inspired "
                            "by Google Developers' family to develop "
                            "projects involving various students "
                            "from different backgrounds. We started our journey in Feb 2019. "
                            "We try to engage student developers through hackathons and "
                            "competitive programming contests. The motive is to create a local "
                            "eco-system of programmers and developers in and around the institute. "
                            "The technology awareness is our motive.", textAlign: TextAlign.center, style: Font_Style.productsans_medium(null, 45),)
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 70.0.w,
                  padding: EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 30.0.h),
                  child: Column(
                    children: <Widget>[
                      Text("Let's Connect", style: Font_Style.productsans_SemiBold(null, 55),),
                      SizedBox(height: 22.0.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(15.0.h),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                            child: SvgPicture.asset("assets/email.svg", height: 80.0.h, width: 80.0.w, color: Colors.white,)),
                          Container(
                              padding: EdgeInsets.all(15.0.h),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: SvgPicture.asset("assets/github.svg", height: 80.0.h, width: 80.0.w, color: Colors.white,)),
                          Container(
                              padding: EdgeInsets.all(15.0.h),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: SvgPicture.asset("assets/instagram.svg", height: 80.0.h, width: 80.0.w, color: Colors.white,)),
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    launchAnyMap(lat: "15.761774", long: "78.036388");
                  },
                  child: Card(
                    elevation: 7.0,
                    margin: EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 20.0.h),
                    color: Colors.white.withOpacity(0.9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 70.0.w,
                      padding: EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 30.0.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2.5,
                        child: Column(
                          children: <Widget>[
                            Text("Visit IIITDM Kurnool", style: Font_Style.productsans_SemiBold(null, 55),),
                            SizedBox(height: 22.0.h,),
                            Text("Google maps(Required google cloud platform)", style: Font_Style.productsans_Regular(null, 50),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
