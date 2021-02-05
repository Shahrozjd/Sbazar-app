import 'package:flutter/material.dart';
import 'constants.dart';

class RectButton extends StatelessWidget {
  String textval;
  double height;
  double width;
  Function onpress;


  RectButton({this.textval, this.height, this.width,this.onpress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: mainaccent,
      ),
      child: MaterialButton(
        splashColor: Colors.transparent,
        onPressed: onpress,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(textval, style: TextStyleMedium),
      ),
    );
  }
}
