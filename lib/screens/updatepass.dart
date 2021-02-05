import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sbazarapp/components/DarkTextField.dart';
import 'package:sbazarapp/components/RectButton.dart';
import 'package:sbazarapp/models/userprofile_model.dart';
import 'package:sbazarapp/services/userprofile_services.dart';
import 'package:toast/toast.dart';

class updatepasspage extends StatefulWidget {
  String email;


  updatepasspage({this.email});

  @override
  _updatepasspageState createState() => _updatepasspageState();
}

class _updatepasspageState extends State<updatepasspage> {
  String pass;
  bool loading = false;

  updatepass(userprofile_model userprof)async{
    await userprofile_services().UpdateUserPassword(userprof).then((value){
      final body = json.decode(value);
      print(body['data'].toString());
      final int success = (body['success']);
      setState(() {
        if(success == 1)
        {
          loading = false;
          Toast.show("Password Updated Successfully", context,gravity: Toast.BOTTOM,duration: 3);
        }
        else{
          loading = false;
          Toast.show("Error Updating password", context,gravity: Toast.BOTTOM,duration: 3);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
        appBar: AppBar(title: Text('Change Password'),),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DarkTextField(
                hasfocus: true,
                obscuretext: false,
                inputtype: TextInputType.text,
                labeltext: 'New Password',
                hintext: 'Enter your New Password',
                onChanged: (String getPass) {
                  pass = getPass;
                },
              ),
              SizedBox(
                height: 10,
              ),
              RectButton(
                textval: "Update Password",
                onpress: (){

                  if(pass != null){
                  FocusScope.of(context).unfocus();
                  setState(() {
                    loading = true;
                  });
                  userprofile_model userprof = userprofile_model(
                    email: widget.email,
                      password: pass
                  );
                  updatepass(userprof);
                  }
                  else{
                    Toast.show("Please enter password", context,gravity: Toast.BOTTOM,duration: 3);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
