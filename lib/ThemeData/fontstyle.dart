import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Font_Style {
  static Color primaryColor=Color.fromRGBO(7,9,32, 1);
  static Color secondaryColor=Color.fromRGBO(7,9,32, 1).withOpacity(0.5);

//to set the label for input text field
  static InputDecoration setLabel(String label, Icon prefixIcon, var suffixIcon, BuildContext context) {
    return InputDecoration(
      //isDense: true,
        labelText:label,
        counterText: "",
        focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 8.0.w),
        labelStyle: productsans_medium(secondaryColor, 45.0),
      suffixIcon: suffixIcon == null ? null : suffixIcon,
      prefixIcon: prefixIcon == null ? null : prefixIcon,
    );
  }

  static InputDecoration setLabelAllBorders(String label, Icon prefixIcon, var suffixIcon, BuildContext context) {
    return InputDecoration(
      //isDense: true,
      labelText:label,
      counterText: "",
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: secondaryColor, width: 1,),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: secondaryColor, width: 1),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: secondaryColor, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: secondaryColor, width: 1),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 15.0),
      labelStyle: productsans_SemiBold(primaryColor.withOpacity(0.7), 45.0),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }
  
  static TextStyle textfield_style(){
    return productsans_medium(primaryColor.withOpacity(0.7), 50);
  }
  static TextStyle productsans_black(Color primary,double f1_32){
    return TextStyle(
      fontFamily: "ProductSans",
      fontWeight: FontWeight.w800,
      color: primary==null?primaryColor:primary,
      fontSize: f1_32==null?ScreenUtil().setSp( 32.0,allowFontScalingSelf: true):ScreenUtil().setSp(f1_32,allowFontScalingSelf: true),
    );
  }

  static TextStyle productsans_ExtraBold(Color primary,double f3_20){
    return TextStyle(
      fontFamily: "ProductSans",
      fontWeight: FontWeight.w900,
      color: primary==null?primaryColor:primary,
      fontSize: f3_20==null?ScreenUtil().setSp(19,allowFontScalingSelf: true):ScreenUtil().setSp(f3_20,allowFontScalingSelf: true),
    );
  }

  static TextStyle productsans_Bold(Color primary,double f3_19){
    return TextStyle(
      fontFamily: "ProductSans",
      fontWeight: FontWeight.w700,
      color: primary==null?primaryColor:primary,
      fontSize: f3_19==null?ScreenUtil().setSp(19,allowFontScalingSelf: true):ScreenUtil().setSp(f3_19,allowFontScalingSelf: true),
    );
  }
  static TextStyle productsans_SemiBold(Color primary,double f5_14){
    return TextStyle(
      fontFamily: "ProductSans",
      fontWeight: FontWeight.w600,
      color: primary==null?primaryColor:primary,
      fontSize: f5_14==null?ScreenUtil().setSp(14,allowFontScalingSelf: true):ScreenUtil().setSp(f5_14,allowFontScalingSelf: true),
    );
  }
  static TextStyle productsans_SemiBold_underline(Color primary,double f5_14){
    return TextStyle(
      fontFamily: "ProductSans",
      fontWeight: FontWeight.w600,
      color: primary==null?primaryColor:primary,
      decoration: TextDecoration.underline,
      fontSize: f5_14==null?ScreenUtil().setSp(14,allowFontScalingSelf: true):ScreenUtil().setSp(f5_14,allowFontScalingSelf: true),
    );
  }
  static TextStyle productsans_medium(Color primary,double f4_16){
    return TextStyle(
      fontFamily: "ProductSans",
      fontWeight: FontWeight.w400,
      color: primary==null?primaryColor:primary,
      fontSize: f4_16==null?ScreenUtil().setSp(16,allowFontScalingSelf: true):ScreenUtil().setSp(f4_16,allowFontScalingSelf: true),
    );
  }
  static TextStyle productsans_Regular(Color primary,double f6_12){
    return TextStyle(
      fontFamily: "ProductSans",
      fontWeight: FontWeight.w300,
      color: primary==null?primaryColor:primary,
      fontSize: f6_12==null?ScreenUtil().setSp(12,allowFontScalingSelf: true):ScreenUtil().setSp(f6_12,allowFontScalingSelf: true),
    );
  }

  static TextStyle productsans_Regular_Underline(Color primary,double f6_12){
    return TextStyle(
        fontFamily: "ProductSans",
        fontWeight: FontWeight.w300,
        color: primary==null?primaryColor:primary,
        fontSize: f6_12==null?ScreenUtil().setSp(12,allowFontScalingSelf: true):ScreenUtil().setSp(f6_12,allowFontScalingSelf: true),
        decoration: TextDecoration.underline,
        decorationColor: primary==null?primaryColor:primary,
    );
  }

  static TextStyle productsans_Light(Color primary, double f6_12) {
    return TextStyle(
      fontFamily: "ProductSans",
      fontWeight: FontWeight.w300,
      color: primary==null?primaryColor:primary,
      fontSize: f6_12==null?ScreenUtil().setSp(12,allowFontScalingSelf: true):ScreenUtil().setSp(f6_12,allowFontScalingSelf: true),
    );
  }

  static TextStyle productsans_thin(Color primary,double f7_14){
    return TextStyle(
      fontFamily: "ProductSans",
      fontWeight: FontWeight.w300,
      color: primary==null?primaryColor:primary,
      fontSize: f7_14==null?ScreenUtil().setSp(14,allowFontScalingSelf: true):ScreenUtil().setSp(f7_14,allowFontScalingSelf: true),
    );
  }

  static TextStyle productsans_thin_Underline(Color primary,double f7_14){
    return TextStyle(
        fontFamily: "ProductSans",
        fontWeight: FontWeight.w300,
        color: primary==null?primaryColor:primary,
        fontSize: f7_14==null?ScreenUtil().setSp(14,allowFontScalingSelf: true):ScreenUtil().setSp(f7_14,allowFontScalingSelf: true),
        decoration: TextDecoration.underline,
        decorationColor: primaryColor
    );
  }
}