import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

AppBar buildAppBar({String title,String amount}) {
  return AppBar(
    title: Text(title),
    actions: [
      InkWell(
        onTap: () {},
        splashColor: Colors.white.withOpacity(0.4),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Badge(
            badgeColor: Colors.white,
            badgeContent: Text(amount),
            child: Icon(FontAwesomeIcons.shoppingCart),
          ),
        ),
      )
    ],
  );
}
