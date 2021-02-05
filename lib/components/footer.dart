import 'package:flutter/material.dart';
import 'constants.dart';

_footerbarState footerbarstate;
class footerbar extends StatefulWidget {
  int points ;
  double saveprice ;
  bool showfooter = false;

  footerbar({this.points, this.saveprice,this.showfooter});

  @override
  _footerbarState createState(){
    footerbarstate = _footerbarState(points,saveprice,showfooter);
    return footerbarstate;
  }
}

class _footerbarState extends State<footerbar> {
  bool showfooter = false;
  int points ;
  double saveprice ;

  _footerbarState(this.points, this.saveprice,this.showfooter);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showfooter,
      child: Container(
        color: mainaccent,
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(points.toString()+" points",style: TextStyle(color: Colors.white),),
            Text("Saved "+saveprice.toStringAsFixed(2)+" € from market price",style: TextStyle(color: Colors.white),)
          ],
        ),
      ),
    );
  }
}
