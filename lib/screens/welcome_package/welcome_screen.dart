import 'dart:async';

import 'package:dsc_iiitdmkl/ThemeData/fontstyle.dart';
import 'package:dsc_iiitdmkl/screens/components/bottom_nav.dart';
import 'package:dsc_iiitdmkl/services/user_details_firebase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'bubble_painter.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _circularController;
  List<Bubble> bubbles;
  final int numberOfBubbles = 20;
  final Color color = Colors.white.withOpacity(0.5);
  final double maxBubbleSize = 45.0;

  @override
  void initState() {
    super.initState();
    bubbles = List();
    int i = numberOfBubbles;
    while(i > 0) {
      bubbles.add(Bubble(color, maxBubbleSize));
      i--;
    }

    _controller = new AnimationController(
        duration: const Duration(seconds: 1500), vsync: this);
    _controller.addListener(() {
      updateBubblePosition();
    });
    _controller.forward();

    _circularController = AnimationController(
        duration: const Duration(milliseconds: 1300), vsync: this);
    _circularController.repeat();

    initializeFirebase();

    Timer(Duration(milliseconds: 2500), () {
      navigateToScreen();
    });
  }

  void navigateToScreen() {
    UserDetails.getUserId(context);
    if(UserDetails.firebaseUser != null) {
      Navigator.push(context,
        MaterialPageRoute(builder: (context) =>
            BottomNav(currentIndex: 2,)),);
    }
    else {
      Navigator.pushNamed(context, "login_register");
    }
  }

  Future initializeFirebase() {
    Firebase.initializeApp();
  }

  @override
  void dispose() {
    _controller.dispose();
    _circularController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.width / 3,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(MediaQuery.of(context).size.width / 3)),
                          color: Color.fromRGBO(234, 67, 53, 1).withOpacity(0.5),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.width / 3,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(MediaQuery.of(context).size.width / 3)),
                          color: Color.fromRGBO(15, 157, 88, 1).withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.width / 3,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(MediaQuery.of(context).size.width / 3)),
                      color: Color.fromRGBO(251, 188, 4, 1).withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Spacer(flex: 10 ,),
                  Container(
                    margin: EdgeInsets.all(40.0.h),
                      child: Image.asset('assets/logo.png', fit: BoxFit.cover,)
                  ),
                  Spacer(flex: 1,),
                  Text("DEVELOPER STUDENT CLUBS", style: Font_Style.productsans_Bold(Colors.black54, 70),),
                  Spacer(flex: 1,),
                  Text("IIITDM Kurnool", style: Font_Style.productsans_Bold(Colors.black54, 70),),
                  Spacer(flex: 3,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.only(right: 50.0.w),
                      height: MediaQuery.of(context).size.width / 2.5,
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(81, 133, 235, 1).withOpacity(0.5)
                      ),
                    ),
                  ),
                  Spacer(flex: 6,),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 150.0.h),
                      child: RotationTransition(
                          turns: CurveTween(curve: Curves.easeInOutSine).animate(_circularController),
                          child: SvgPicture.asset("assets/loading.svg", height: 120.0.h, width: 120.0.w,)))),
              CustomPaint(
                foregroundPainter: BubblePainter(bubbles: bubbles, controller: _controller),
                size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateBubblePosition() {
    bubbles.forEach((it) => it.updatePosition());
    setState(() {});
  }
}