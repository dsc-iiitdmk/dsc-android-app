import 'package:dsc_iiitdmkl/Backend/ChangeNotifiers/developers_data.dart';
import 'package:dsc_iiitdmkl/Backend/DataClasses/DevelopersDataClass.dart';
import 'package:dsc_iiitdmkl/ThemeData/fontstyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Developers extends StatelessWidget {

  double height;
  double width;

  @override
  Widget build(BuildContext context) {

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    Provider.of<LoadDevelopersData>(context).loadDevelopersData();
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back, size: 24.0, color: Font_Style.primaryColor,)),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Developers' Contact", textAlign: TextAlign.left, style: Font_Style.productsans_Bold(null, 60)),
      ),
      body: Container(
        height: height,
        width: width,
        child: ListView.builder(itemBuilder: (_, index) {
          return developersCard(Provider.of<LoadDevelopersData>(context).developerDataList.elementAt(index));
        }, itemCount: Provider.of<LoadDevelopersData>(context).developerDataList != null ? Provider.of<LoadDevelopersData>(context).developerDataList.length : 0
      ),
      ),
    );
  }

  Widget developersCard(DevelopersDataClass developer){
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
                child: Image.network(developer.devImgUrl, fit: BoxFit.fill , height: height /6,),
              ),),
              Expanded(flex: 4, child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(developer.devName, style: Font_Style.productsans_Bold(Colors.black, 60),),
                    Text(developer.devEmail, style: Font_Style.productsans_medium(Colors.black54, 45)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(onTap: () async {await launch(developer.devGitLink);}, child: SvgPicture.asset("assets/github.svg", height: 60.0.h, width: 60.0.w, color: Colors.black,),),
                        SizedBox(width: 20,),
                        InkWell(onTap: () async {await launch(developer.devInstaLink);}, child: SvgPicture.asset("assets/instagram.svg", height: 60.0.h, width: 60.0.w, color: Color.fromRGBO(225, 48, 108, 1),),),
                        SizedBox(width: 20,),
                        InkWell(onTap: () async {await launch(developer.devLinkedinLink);}, child: SvgPicture.asset("assets/linkedin.svg", height: 60.0.h, width: 60.0.w,),),
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
/*Provider.of<LoadDevelopersData>(context).developerDataList.elementAt(0).devName.toString()*/