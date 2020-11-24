import 'package:dsc_iiitdmkl/screens/events_package/events_botnav.dart';
import 'package:dsc_iiitdmkl/screens/home_package/home_botnav.dart';
import 'package:dsc_iiitdmkl/screens/members_package/members_botnav.dart';
import 'package:dsc_iiitdmkl/screens/profile_package/profile_botnav.dart';
import 'package:dsc_iiitdmkl/screens/projects_package/projects_botnav.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNav extends StatefulWidget {
  int currentIndex;
  BottomNav({this.currentIndex});

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List<Widget> _botNavList;

  @override
  void initState() {
    super.initState();
    if (widget.currentIndex == null) {
      setState(() {
        widget.currentIndex = 2;
      });
    }
    _botNavList = [
      EventsBotNav(),
      MembersBotNav(),
      HomeBotNav(),
      ProjectsBotNav(),
      ProfileBotNav(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.cyanAccent,
      statusBarBrightness: Brightness.dark,
    ));
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        body: SafeArea(child: _botNavList[widget.currentIndex]),
        bottomNavigationBar: CurvedNavigationBar(
          items: <Widget>[
            SvgPicture.asset("assets/calendar.svg", color: Colors.white, height: 50.0.h, width: 50.0.w,),
            SvgPicture.asset("assets/group.svg", color: Colors.white, height: 50.0.h, width: 50.0.w,),
            SvgPicture.asset("assets/home.svg", color: Colors.white, height: 50.0.h, width: 50.0.w,),
            SvgPicture.asset("assets/project-management.svg", color: Colors.white, height: 50.0.h, width: 50.0.w,),
            SvgPicture.asset("assets/profile-user.svg", color: Colors.white, height: 50.0.h, width: 50.0.w,),
          ],
          index: 2,
          height: 140.0.h,
          backgroundColor: Colors.grey[100],
          color: Colors.cyan[900],
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          onTap: (index) {
            setState(() {
              widget.currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
