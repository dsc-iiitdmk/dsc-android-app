import 'package:dsc_iiitdmkl/Backend/ChangeNotifiers/members_data.dart';
import 'package:dsc_iiitdmkl/Backend/DataClasses/Member.dart';
import 'package:dsc_iiitdmkl/ThemeData/fontstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

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
    String currentMemberDomain;

    Provider.of<LoadMembersData>(context).loadMembers();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Team Members", textAlign: TextAlign.left, style: Font_Style.productsans_Bold(null, 60)),
      ),
      body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Container(
                height: 100,
                child: PageView.builder(
                  itemCount: Provider.of<LoadMembersData>(context).membersList.length,
                  controller: PageController(viewportFraction: 0.4),
                  onPageChanged: (int index) => setState(() {
                    _index = index;
                  }),
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
                        child: Text(Provider.of<LoadMembersData>(context).membersList.keys.elementAt(i), style: Font_Style.productsans_Bold(Colors.white, 48), textAlign: TextAlign.center,),
                      ),
                    );
                  },
                ),
              ),
              Expanded(child: ListView.builder(itemBuilder: (_, index) {
                return membersCard(Provider.of<LoadMembersData>(context).membersList[currentMemberDomain].elementAt(index));
              }, itemCount: Provider.of<LoadMembersData>(context).membersList != null && Provider.of<LoadMembersData>(context).membersList.containsKey(Provider.of<LoadMembersData>(context).membersList.keys.elementAt(_index)) ? Provider.of<LoadMembersData>(context).membersList[Provider.of<LoadMembersData>(context).membersList.keys.elementAt(_index)].length : 0,),
              flex: 1,)
            ],
          ),
      ),
    );
  }

  Widget membersCard(Member member){
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: height/6.3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(member.image, fit: BoxFit.fill , height: height /6,),
            ),),
            Expanded(flex: 4, child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(member.name, style: Font_Style.productsans_Bold(Colors.black, 60),),
                  Text(member.batch, style: Font_Style.productsans_medium(Colors.black54, 45)),
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