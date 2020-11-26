import 'dart:async';

import 'package:dsc_iiitdmkl/Backend/ChangeNotifiers/home_data.dart';
import 'package:dsc_iiitdmkl/Backend/DataClasses/Home.dart';
import 'package:dsc_iiitdmkl/ThemeData/fontstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomeBotNav extends StatefulWidget {
  @override
  _HomeBotNavState createState() => _HomeBotNavState();
}

class _HomeBotNavState extends State<HomeBotNav> with TickerProviderStateMixin {
  Animation<int> _totalCharacterCount;
  AnimationController _totalTextController;

  String _totalString = "Developer Student Club IIITDM Kurnool";

  static final MarkerId _markerId = MarkerId("shopLocationMarkerId");

  Completer<GoogleMapController> _googleMapsController = Completer();

  CameraPosition _camPosition = CameraPosition(
    target: LatLng(15.761774, 78.036388),
    zoom: 14.4746,
  );

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

  @override
  Widget build(BuildContext context) {
    Provider.of<LoadHomeData>(context).loadHomeData();

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Material(
                elevation: 1.0,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height / 3 - 70.0.h,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: SvgPicture.asset("assets/home_bg.svg", height: MediaQuery.of(context).size.height / 3 - 70.0.h, width: MediaQuery.of(context).size.width,),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 18.0.w, top: 18.0.h),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                            width: 150.0.w,
                            height: 150.0.h,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image: AssetImage("assets/iiitdmk-logo.png")
                                )
                            )
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 3 - 70.0.h,
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                width: 280.0.w,
                                height: 100.0.h,
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
                              width: MediaQuery.of(context).size.width - 520.0.w,
                              child: Text(_totalString, textDirection: TextDirection.ltr, textAlign: TextAlign.center, style: Font_Style.productsans_Bold(Font_Style.primaryColor.withOpacity(0.7), 50,)))
                                : AnimatedBuilder(
                              animation: _totalCharacterCount,
                              builder: (BuildContext context, Widget child) {
                                String _displayText = _totalString.substring(0, _totalCharacterCount.value);
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width - 520.0.w,
                                    child: Text(_displayText, textDirection: TextDirection.ltr, textAlign: TextAlign.center, style: Font_Style.productsans_Bold(Font_Style.primaryColor.withOpacity(0.7), 50,)));
                              },
                            ),
                            SizedBox(height: 50.0.h,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0.h,),
                      Column(
                        children: Provider.of<LoadHomeData>(context).homeData != null ? <Widget>[
                          for(HomeCard card in Provider.of<LoadHomeData>(context).homeData.homeCards) HomeCardView(context, card.title, card.text)
                        ] : [],
                      ),
                      SizedBox(height: 40.0.h,),
                      Text("Let's Connect", style: Font_Style.productsans_Bold(null, 60),),
                      SizedBox(height: 30.0.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(18.0.h),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: SvgPicture.asset("assets/email.svg", height: 80.0.h, width: 80.0.w, color: Colors.white,)),
                          Container(
                              padding: EdgeInsets.all(18.0.h),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: SvgPicture.asset("assets/github.svg", height: 80.0.h, width: 80.0.w, color: Colors.white,)),
                          Container(
                              padding: EdgeInsets.all(18.0.h),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: SvgPicture.asset("assets/instagram.svg", height: 80.0.h, width: 80.0.w, color: Colors.white,)),
                        ],
                      ),
                      SizedBox(height: 40.0.h,),
                      Card(
                        elevation: 7.0,
                        margin: EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 20.0.h),
                        color: Colors.white.withOpacity(0.9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 4.0.h,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(top: 30.0.h,),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Column(
                            children: <Widget>[
                              Text("Visit IIITDM Kurnool", style: Font_Style.productsans_Bold(null, 60),),
                              SizedBox(height: 22.0.h,),
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.0), bottomLeft: Radius.circular(20.0)),
                                  child: GoogleMap(
                                    onMapCreated: (GoogleMapController controller) {
                                      _googleMapsController.complete(controller);
                                    },
                                    initialCameraPosition: _camPosition,
                                    scrollGesturesEnabled: true,
                                    tiltGesturesEnabled: true,
                                    trafficEnabled: false,
                                    compassEnabled: true,
                                    rotateGesturesEnabled: true,
                                    //myLocationEnabled: true,
                                    zoomGesturesEnabled: true,
                                    zoomControlsEnabled: true,
                                    liteModeEnabled: true,
                                    mapType: MapType.hybrid,
                                    markers: {
                                      Marker(
                                          markerId: _markerId,
                                          position: LatLng(15.761774, 78.036388)),
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0.h,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget HomeCardView(BuildContext context, String title, String text){
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
          Text(title, style: Font_Style.productsans_Bold(null, 60),),
          SizedBox(height: 50.0.h,),
          Text(text, textAlign: TextAlign.center, style: Font_Style.productsans_medium(null, 45),),
        ],
      ),
    ),
  );
}
