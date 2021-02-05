import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sbazarapp/components/carticon.dart';
import 'package:sbazarapp/components/constants.dart';
import 'package:sbazarapp/screens/Account.dart';
import 'package:sbazarapp/screens/HotCat.dart';
import 'package:sbazarapp/screens/ShoppingPage.dart';
import 'package:sbazarapp/screens/brandcat.dart';
import 'package:sbazarapp/screens/cartpage.dart';
import 'package:sbazarapp/screens/homepage.dart';
import 'package:sbazarapp/screens/mainpage.dart';
import 'categories.dart';

_PersistentBottomBarState mypresistentbottombarstate;

class PersistentBottomBar extends StatefulWidget {
  @override
  _PersistentBottomBarState createState() {
    mypresistentbottombarstate = _PersistentBottomBarState();
    return mypresistentbottombarstate;
  }
}

class _PersistentBottomBarState extends State<PersistentBottomBar> {
  PersistentTabController _controller;
  int productcount = 0;

  Box<int> cartcountbox = Hive.box('cart_count');
  int cartcountkey = 102;

  @override
  void initState() {
    productcount = cartcountbox.get(cartcountkey, defaultValue: 0);
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  List<Widget> _buildScreens() {
    return [
      homepage(),
      shoppingpage(),
      hotcatPage(),
      brandcatpage(),
      cartpage(),
      account(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColor: mainaccent,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.widgets),
        title: ("Category"),
        activeColor: mainaccent,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(FontAwesomeIcons.fire),
        title: ("Hot"),
        activeColor: mainaccent,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(FontAwesomeIcons.box),
        title: ("Brand"),
        activeColor: mainaccent,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        onPressed: () {
          pushNewScreen(
            context,
            screen: cartpage(),
            withNavBar: true, // OPTIONAL VALUE. True by default.
          );
        },
        icon: Badge(
            badgeColor: mainaccent,
            badgeContent: Text(
              productcount.toString(),
              style: TextStyle(color: Colors.white),
            ),
            child: Icon(FontAwesomeIcons.shoppingCart)),
        title: ("Cart"),
        activeColor: mainaccent,
        inactiveColor: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(FontAwesomeIcons.userAlt),
        title: ("Account"),
        activeColor: mainaccent,
        inactiveColor: CupertinoColors.systemGrey,
      ),
    ];
  }

  Future<bool> _onWillPop() async {
    Navigator.pop(context);
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => mainpage()));
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      onWillPop: _onWillPop,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears.
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),

      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style3, // Cho
    );
  }
}
