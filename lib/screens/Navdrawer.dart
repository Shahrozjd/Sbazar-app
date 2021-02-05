import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sbazarapp/components/constants.dart';
import 'package:sbazarapp/screens/ShoppingPage.dart';
import 'package:sbazarapp/screens/favitems.dart';
import 'package:sbazarapp/screens/homepage.dart';
import 'package:sbazarapp/screens/morepage.dart';
import 'package:sbazarapp/screens/serachpage.dart';
import 'Account.dart';
import 'mainpage.dart';

class navdrawer extends StatefulWidget {
  @override
  _navdrawerState createState() => _navdrawerState();
}

class _navdrawerState extends State<navdrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(flex: 1, child: UserHeader()),
          Expanded(
            flex: 2,
            child: draweritems(),
          )
        ],
      ),
    );
  }
}

class UserHeader extends StatefulWidget {
  @override
  _UserHeaderState createState() => _UserHeaderState();
}

class _UserHeaderState extends State<UserHeader> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mainaccent,
      width: MediaQuery.of(context).size.width * 0.85,
      child: DrawerHeader(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/sbazar_navheader.png"),
                fit: BoxFit.cover)),
      ),
    );
  }
}

class draweritems extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          child: ListTile(
            leading: Icon(FontAwesomeIcons.user),
            title: Text("Account"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => account()));
            },
          ),
        ),
        Divider(
          color: Colors.grey,
          height: 10,
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.home),
          title: Text("Home Page"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => homepage()));
          },
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.store),
          title: Text("Market"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => shoppingpage()));
          },
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.search),
          title: Text("Search"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => serachpage(isSearching: false,)));
          },
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.solidHeart),
          title: Text("Favourites"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => favitemspage()));
          },
        ),

//        ListTile(
//          leading: Icon(FontAwesomeIcons.rev),
//          title: Text("Payback"),
//          trailing: Icon(Icons.arrow_forward),
//          onTap: () {
//            Navigator.of(context).pop();
////            Navigator.of(context).pushReplacement(
////              MaterialPageRoute(
////                builder: (BuildContext context) => FriendsPage(),
////              ),
////            );
//          },
//        ),
//        ListTile(
//          leading: Icon(FontAwesomeIcons.list),
//          title: Text("Shopping List"),
//          trailing: Icon(Icons.arrow_forward),
//          onTap: () {
//            Navigator.of(context).pop();
////            Navigator.of(context).pushReplacement(
////              MaterialPageRoute(
////                builder: (BuildContext context) => InstructorPage(),
////              ),
////            );
//          },
//        ),
//        ListTile(
//          leading: Icon(Icons.more),
//          title: Text("More"),
//          trailing: Icon(Icons.arrow_forward),
//          onTap: () {
//            Navigator.of(context).pop();
//            Navigator.of(context).push(
//              MaterialPageRoute(
//                builder: (BuildContext context) => morepage(),
//              ),
//            );
//          },
//        ),
      ],
    );
  }
}
