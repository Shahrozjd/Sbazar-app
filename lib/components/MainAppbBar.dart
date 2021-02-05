import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sbazarapp/screens/mainpage.dart';
import 'package:sbazarapp/screens/serachpage.dart';


MainAppbarState myappbarstate;
class MainAppbar extends StatefulWidget implements PreferredSizeWidget{

  AppBar appBar;
  int point;
  MainAppbar({this.appBar,this.point});

  @override
  MainAppbarState createState(){
    myappbarstate = MainAppbarState();
    return myappbarstate;
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);


}

class MainAppbarState extends State<MainAppbar>{
  static int points;



  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => serachpage(
        isSearching: true,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  @override
  void initState() {
    points = widget.point;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return AppBar(
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      title: InkWell(
        onTap: () {
          pushNewScreen(
            context,
            screen: mainpage(),
            withNavBar: false,
          );
        },
        child: Image.asset(
          'images/horizontal_logo.png',
          height: 120,
          width: 120,
        ),
      ),
      actions: [
        Container(
          padding: EdgeInsets.only(right: 10),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(_createRoute());
                },
                icon: Icon(Icons.search,size: 30,color: Color(0xFF656565),),
              ),
              SizedBox(
                width: 5,
              ),
              IconButton(
                onPressed: () {},
                icon: Badge(
                    badgeColor: Colors.amber,
                    badgeContent: Text(
                      points.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    child: Icon(FontAwesomeIcons.coins,size: 25,color: Color(0xFF656565),)),
              ),
            ],
          ),
        )
      ],
    );
  }


}
