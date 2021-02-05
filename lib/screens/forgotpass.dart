import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sbazarapp/components/DarkTextField.dart';
import 'package:sbazarapp/components/RectButton.dart';
import 'package:sbazarapp/components/RectButtonAlt.dart';
import 'package:sbazarapp/components/constants.dart';
import 'package:sbazarapp/models/forgotpassModel.dart';
import 'package:sbazarapp/services/forgotpassServices.dart';
import 'package:toast/toast.dart';

class forgotpasspage extends StatefulWidget {
  @override
  _forgotpasspageState createState() => _forgotpasspageState();
}

class _forgotpasspageState extends State<forgotpasspage> {
  String email;
  bool loading = false;

  recoverpass(forgotpassmodel fpmodel)async{

    await forgotpassServices().forgotpass(fpmodel).then((value) {
      final body = json.decode(value);
      final msg = body['message'];

      setState(() {
        if (msg.toString().isNotEmpty) {
          loading = false;
          Toast.show(msg.toString(),
              context,
              gravity: Toast.BOTTOM, duration: 4);
        }
      });

    });

  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset("images/sbazar_icon.jpeg",
                width: MediaQuery.of(context).size.width * .25,
                height: MediaQuery.of(context).size.height * .25,),
              SizedBox(height: 20,),
              Text('Enter email to recover password',style: TextStyleFormBlackBold,),
              SizedBox(height: 10,),
              DarkTextField(
                hasfocus: true,
                obscuretext: false,
                inputtype: TextInputType.emailAddress,
                labeltext: "Email",
                hintext: "Enter Email address",
                onChanged: (String getEmail) {
                  email = getEmail;
                },
              ),
              SizedBox(height: 10,),
              RectButton(
                textval: 'Submit',
                onpress: (){
                  if (email != null) {
                    setState(() {
                      loading = true;
                    });
                    FocusScope.of(context).unfocus();
                    forgotpassmodel fpmodel = forgotpassmodel(email: email);
                    recoverpass(fpmodel);
                  }
                  else{
                    Toast.show('Please enter your email',
                        context,
                        gravity: Toast.BOTTOM, duration: 4);
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
