import 'package:dsc_iiitdmkl/ThemeData/fontstyle.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back, size: 24.0, color: Font_Style.primaryColor,)),
        backgroundColor: Colors.grey[100],
        centerTitle: true,
        title: Text("Privacy Policy", textAlign: TextAlign.left, style: Font_Style.productsans_Bold(null, 60)),
        elevation: 0.0,
      ),
      body: Container(
        child: Text("Your Data will be securely stored with us and must be used for professionally.", style: Font_Style.productsans_medium(null, 46),),
      ),
    );
  }
}
