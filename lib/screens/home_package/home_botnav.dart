import 'package:dsc_iiitdmkl/ThemeData/fontstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBotNav extends StatefulWidget {
  @override
  _HomeBotNavState createState() => _HomeBotNavState();
}

class _HomeBotNavState extends State<HomeBotNav> with TickerProviderStateMixin {
  Animation<int> _firstCharacterCount;
  Animation<int> _secondCharacterCount;
  AnimationController _firstTextController;
  AnimationController _secondTextController;
  
  String _firstString = "Welcome to Developer Student Club";
  String _secondString = "IIITDM Kurnool";

  @override
  void initState() {
    super.initState();
    _firstTextController = new AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );
    _secondTextController = new AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );
    setState(() {
      _firstCharacterCount = new StepTween(begin: 0, end: _firstString.length)
          .animate(
          new CurvedAnimation(parent: _firstTextController, curve: Curves.easeIn));

      _secondCharacterCount = new StepTween(begin: 0, end: _secondString.length)
          .animate(
          new CurvedAnimation(parent: _secondTextController, curve: Curves.easeIn));
    });
    _firstTextController.forward();
    _secondTextController.forward();
  }

  @override
  void dispose() {
    _firstTextController.dispose();
    _secondTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                          _firstCharacterCount == null
                              ? Text("Welcome to Developer Student Club", style: Font_Style.productsans_Bold(Colors.white, 50,))
                              : new AnimatedBuilder(
                            animation: _firstCharacterCount,
                            builder: (BuildContext context, Widget child) {
                              String text = _firstString.substring(0, _firstCharacterCount.value);
                              return new Text(text, style: Font_Style.productsans_Bold(Colors.white, 50,));
                            },
                          ),
                          SizedBox(height: 8.0.h,),
                          _secondCharacterCount == null
                              ? Text("IIITDM Kurnool", style: Font_Style.productsans_Bold(Colors.white, 50,))
                              : new AnimatedBuilder(
                            animation: _secondCharacterCount,
                            builder: (BuildContext context, Widget child) {
                              String text = _secondString.substring(0, _secondCharacterCount.value);
                              return new Text(text, style: Font_Style.productsans_Bold(Colors.white, 50,));
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

              ],
            ),
          ),
        ),
      ),
    );
  }
}
