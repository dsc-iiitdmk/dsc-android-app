import 'package:dsc_iiitdmkl/ThemeData/fontstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MembersBotNav extends StatefulWidget{

  _MembersBotNavState createState() => _MembersBotNavState();
}

class _MembersBotNavState extends State<MembersBotNav> with TickerProviderStateMixin{
  var height, width;
  int _index = 0;

  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Team Members", textAlign: TextAlign.left, style: Font_Style.productsans_Bold(null, 68)),
      ),
      body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Container(
                height: 100,
                child: PageView.builder(
                  itemCount: 10,
                  controller: PageController(viewportFraction: 0.4),
                  onPageChanged: (int index) => setState(() => _index = index),
                  itemBuilder: (_, i) {
                    return Transform.scale(
                      scale: i == _index ? 1 : 0.6,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.cyan[900].withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(40),
                        child: i == 0 ? Text("Android", style: Font_Style.productsans_Bold(Colors.white, 48), textAlign: TextAlign.center,) : Text("Web", style: Font_Style.productsans_Bold(Colors.white, 48), textAlign: TextAlign.center,),
                      ),
                    );
                  },
                ),
              ),
              Expanded(child: ListView.builder(itemBuilder: (_, index) {
                return membersCard();
              }, itemCount: 10,),
              flex: 1,)
            ],
          ),
      ),
    );
  }

  Widget membersCard(){
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: height/6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network("https://firebasestorage.googleapis.com/v0/b/aegle-e153c.appspot.com/o/HomeTiles%2Faboutus.png?alt=media&token=cfc92220-6077-41ed-8e14-dc654c5e1fc", fit: BoxFit.fill , height: height /6,),
            ),),
            Expanded(flex: 3, child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Adarsh Shrivastava", style: Font_Style.productsans_Bold(Colors.black, 60),),
                  Text("ECE, BTech 2019", style: Font_Style.productsans_medium(Colors.black54, 45)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/github.svg", height: 60.0.h, width: 60.0.w, color: Colors.black,),
                      SizedBox(width: 20,),
                      SvgPicture.asset("assets/instagram.svg", height: 60.0.h, width: 60.0.w, color: Color.fromRGBO(225, 48, 108, 1),),
                      SizedBox(width: 20,),
                      SvgPicture.asset("assets/linkedin.svg", height: 60.0.h, width: 60.0.w,),
                    ],
                  )
                ],
              ),
            )),
          ],
        ),
      )
    );
  }
}