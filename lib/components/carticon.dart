import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sbazarapp/screens/cartpage.dart';

_carticonState mycartstate;

class carticon extends StatefulWidget {
  int productcount;


  carticon({this.productcount});

  @override
  _carticonState createState() {
   mycartstate =  _carticonState(productcount);
   return mycartstate;
  }
}

class _carticonState extends State<carticon> {
  int productcount;


  _carticonState(this.productcount);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Badge(
        badgeColor: Colors.white,
        badgeContent: Text(productcount.toString()),
        child: Icon(FontAwesomeIcons.shoppingCart),
      ),
    );
  }
}
