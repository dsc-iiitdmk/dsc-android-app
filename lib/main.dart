import 'package:dsc_iiitdmkl/screens/events_package/events_botnav.dart';
import 'package:dsc_iiitdmkl/screens/home_package/home_botnav.dart';
import 'package:dsc_iiitdmkl/screens/login_register_package/login_register.dart';
import 'package:dsc_iiitdmkl/screens/welcome_package/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ThemeData/fontstyle.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DSC IIITDMKL',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'ProductSans',
        scaffoldBackgroundColor: Colors.grey[50],
        primaryColor: Font_Style.primaryColor,
        cursorColor: Font_Style.secondaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => WelcomeScreen(),
        'homebotnav': (context) => HomeBotNav(),
        'login_register': (context) => LoginRegister(),
      },
      initialRoute: '/',
    );
  }
}