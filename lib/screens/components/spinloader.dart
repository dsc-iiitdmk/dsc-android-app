import 'package:dsc_iiitdmkl/ThemeData/fontstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget spinLoader(double w, double h) {
  return Container(
    width: w,
    height: h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: Colors.blue.shade300,
    ),
    child: Center(
      child: SpinKitChasingDots(color: Colors.white,size: 20,),
    )
  );
}
Widget loadingScreen(context){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    child: Center(
      child: SpinKitChasingDots(color: Font_Style.primaryColor,size: 56,),
    ),
  );
}