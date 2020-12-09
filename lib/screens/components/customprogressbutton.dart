import 'package:dsc_iiitdmkl/ThemeData/fontstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


Widget customButtonWidget(BuildContext context, IconData iconData, state, onPress) {
  return Container(
    child: ProgressButton(
      maxWidth: 80.0,
      height: 52.0,
      radius: 52.0,
      onPressed: onPress,
      stateColors: {
        ButtonState.idle: Color.fromRGBO(0, 207, 200, 1),
        ButtonState.loading: Colors.blue.shade300,
        ButtonState.fail: Colors.red.shade300,
        ButtonState.success: Colors.green.shade400,
      },
      stateWidgets: {
        ButtonState.idle: registerLoginButton(iconData),
        ButtonState.loading: registerLoginButton(iconData),
        ButtonState.fail: registerLoginButton(iconData),
        ButtonState.success:registerLoginButton(iconData),
      },
      state: state,
      padding: EdgeInsets.all(5.0),
    ),
  );
}

Widget registerLoginButton(IconData iconData) {
  return Material(
    clipBehavior: Clip.hardEdge,
    color: Colors.transparent,
    child: Center(
      child: Icon(iconData, size: 24, color: Colors.white,),
    ),
  );
}
