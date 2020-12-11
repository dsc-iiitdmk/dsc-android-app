import 'package:dsc_iiitdmkl/Backend/ChangeNotifiers/events_data.dart';
import 'package:dsc_iiitdmkl/Backend/ChangeNotifiers/home_data.dart';
import 'package:dsc_iiitdmkl/Backend/ChangeNotifiers/members_data.dart';
import 'package:dsc_iiitdmkl/Backend/ChangeNotifiers/project_data.dart';
import 'package:dsc_iiitdmkl/screens/events_package/event_form.dart';
import 'package:dsc_iiitdmkl/screens/home_package/home_botnav.dart';
import 'package:dsc_iiitdmkl/screens/login_register_package/forgot_pass.dart';
import 'package:dsc_iiitdmkl/screens/login_register_package/login_register.dart';
import 'package:dsc_iiitdmkl/screens/myreg_package/MyRegistration.dart';
import 'package:dsc_iiitdmkl/screens/profile_package/ProfileEdit.dart';
import 'package:dsc_iiitdmkl/screens/welcome_package/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Backend/ChangeNotifiers/form_data.dart';
import 'ThemeData/fontstyle.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<LoadHomeData>(create: (_) => LoadHomeData()),
      ChangeNotifierProvider<LoadMembersData>(create: (_) => LoadMembersData()),
      ChangeNotifierProvider<LoadProjectData>(create: (_) => LoadProjectData()),
      ChangeNotifierProvider<LoadEventsData>(create: (_) => LoadEventsData()),
      ChangeNotifierProvider<FormData_Data>(create: (_) => FormData_Data()),
    ],
    child: MyApp(),
  ));

  // runApp(ChangeNotifierProvider<LoadHomeData>(
  //   create: (_) => LoadHomeData(),
  //   child: ChangeNotifierProvider<LoadMembersData>(
  //     create: (_) => LoadMembersData(),
  //     child: MyApp(),
  //   ),
  // ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'DSC IIITDMKL',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'ProductSans',
        scaffoldBackgroundColor: Colors.grey[100],
        primaryColor: Font_Style.primaryColor,
        cursorColor: Font_Style.secondaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => WelcomeScreen(),
        'home_bot_nav': (context) => HomeBotNav(),
        'login_register': (context) => LoginRegister(),
        'forgot_pass': (context) => ForgotPassword(),
        'profile_edit': (context) => ProfileEdit(),
        'event_form': (context) => EventForm(),
        'my_registration': (context) => MyRegistration(),
      },
      initialRoute: '/',
    );
  }
}