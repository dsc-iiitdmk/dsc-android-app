import 'package:dsc_iiitdmkl/screens/home_package/home_botnav.dart';
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
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Font_Style.primaryColor,
        cursorColor: Font_Style.secondaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => WelcomeScreen(),
        'homebotnav': (context) => HomeBotNav(),
      },
      initialRoute: '/',
    );
  }
}