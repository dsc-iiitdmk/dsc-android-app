import 'package:dsc_iiitdmkl/ThemeData/fontstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void showSnackBar(BuildContext context, String errorLine, Color bgColor, IconData icon, Color iconColor, Color textColor) {
  Scaffold.of(context).hideCurrentSnackBar();
  Scaffold.of(context).showSnackBar(SnackBar(
    duration: Duration(seconds: 5),
    backgroundColor: bgColor,
    content: GestureDetector(
      child: Container(
        height: 40.0.h,
        width: 390.0.w,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(icon, size: 20, color: iconColor,),
            SizedBox(width: 8.0.w,),
            Flexible(child: Text(errorLine, textDirection: TextDirection.ltr, textAlign: TextAlign.left, style: Font_Style.productsans_medium(textColor, 36),)),
          ],
        ),
      ),
    ),
  ));
}

Widget progressIndicator() {
  return SpinKitFadingCircle(
    color: Font_Style.secondaryColor,
    size: 50.0,
  );
}