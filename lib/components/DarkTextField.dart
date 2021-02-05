import 'package:flutter/material.dart';
import 'constants.dart';

class DarkTextField extends StatelessWidget {
  bool obscuretext;
  var inputtype;
  String labeltext,hintext;
  Function onChanged;
  TextEditingController controller;
  bool hasfocus;


  DarkTextField({this.obscuretext, this.inputtype, this.labeltext,this.hintext, this.onChanged,this.controller,this.hasfocus});

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: hasfocus,
      controller: controller,
      onChanged: onChanged,
      obscureText: obscuretext,
      keyboardType: inputtype,
      style: TextStyleFormBlack,
      decoration: InputDecoration(
        hintText: hintext,
        labelText: labeltext,
        labelStyle:
        TextStyleFormBlack,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: mainaccent),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}