import 'package:dsc_iiitdmkl/Backend/ChangeNotifiers/project_data.dart';
import 'package:dsc_iiitdmkl/Backend/DataClasses/Project.dart';
import 'package:dsc_iiitdmkl/ThemeData/fontstyle.dart';
import 'package:dsc_iiitdmkl/screens/components/common_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsBotNav extends StatefulWidget{

  _ProjectsBotNavState createState() => _ProjectsBotNavState();
}

class _ProjectsBotNavState extends State<ProjectsBotNav> with TickerProviderStateMixin{
  var height, width;

  @override
  void initState() {
    // TODO: implement initState

  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    Provider.of<LoadProjectData>(context).loadProjects();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Projects", textAlign: TextAlign.left, style: Font_Style.productsans_Bold(null, 60)),
      ),
      body: SafeArea(
          child: Provider.of<LoadProjectData>(context).projects != null ? getListItemCount() != 0 ? ListView.builder(itemBuilder: (context, index){
            return projectsCard(Provider.of<LoadProjectData>(context).projects.elementAt(index));
          }, scrollDirection: Axis.vertical, itemCount: getListItemCount(), padding: EdgeInsets.symmetric(vertical: 10),)
              : Container(
            child: Center(child: Text("No Data", style: Font_Style.productsans_medium(Font_Style.primaryColor.withOpacity(0.2), 56),),),
          ) : progressIndicator(),
      ),
    );
  }

  getListItemCount(){
    return Provider.of<LoadProjectData>(context).projects != null ? Provider.of<LoadProjectData>(context).projects.length : 0;
  }

  Widget projectsCard(Project project){
    return Card(
        elevation: 3.0,
        margin: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 250.0.h,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(project.name, textDirection: TextDirection.ltr, overflow: TextOverflow.ellipsis, style: Font_Style.productsans_Bold(Colors.black, 60), textAlign: TextAlign.center,),
                  SizedBox(height: 15,),
                  Text(project.desc, textDirection: TextDirection.ltr, overflow: TextOverflow.ellipsis, style: Font_Style.productsans_medium(Colors.grey[800], 45), textAlign: TextAlign.center,),
                ],
              ),
              Spacer(),
              Container(child: InkWell(child: SvgPicture.asset("assets/github.svg", height: 80.0.h, width: 80.0.w, color: Colors.black,), onTap: () async {await launch(project.gitLink);},),),
            ],
          )
        )
    );
  }


}