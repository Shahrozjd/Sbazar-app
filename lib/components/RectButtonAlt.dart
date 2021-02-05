import 'package:flutter/material.dart';
import 'constants.dart';

class RectButtonAlt extends StatelessWidget {
  String textval;
  double height;
  double width;
  Function onpress;


  RectButtonAlt({this.textval, this.height, this.width,this.onpress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: MaterialButton(
        splashColor: Colors.transparent,
        onPressed: onpress,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(textval, style: TextStyleFormAccent),
      ),
    );
  }
}
