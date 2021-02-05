import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sbazarapp/components/AlertDialog.dart';
import 'package:sbazarapp/components/DarkTextField.dart';
import 'package:sbazarapp/components/RectButton.dart';
import 'package:sbazarapp/components/RectButtonAlt.dart';
import 'package:sbazarapp/components/RoundButton.dart';
import 'package:sbazarapp/components/constants.dart';
import 'package:sbazarapp/models/customer_login_model.dart';
import 'package:sbazarapp/screens/Navdrawer.dart';
import 'package:sbazarapp/screens/Registerpage.dart';
import 'package:sbazarapp/screens/forgotpass.dart';
import 'package:sbazarapp/screens/mainpage.dart';
import 'package:sbazarapp/screens/userprofile.dart';
import 'package:sbazarapp/services/customer_login_services.dart';
import 'package:toast/toast.dart';

class account extends StatefulWidget {
  @override
  _accountState createState() => _accountState();
}

class _accountState extends State<account> {
  Box sessionBox = Hive.box('logincheck');
  int usersessionkey = 100;
  int useremailkey = 101;
  String useremail;
  bool usersession;

  bool loading = false;
  String email;
  String password;


  //fb auth
  Map<String, dynamic> _userData;
  AccessToken _accessToken;
  bool _checking = true;

  loginuser(customer_login_model clogin_model, BuildContext context) async {
    await customer_login_services().LoginCustomer(clogin_model).then((value) {
      final body = json.decode(value);
      final String success = body['success'];
      final String msg = body['message'];
      setState(() {
        if (success == '1') {
          sessionBox.put(usersessionkey, true);
          sessionBox.put(useremailkey, email);
          pushNewScreen(
            context,
            screen: mainpage(),
            withNavBar: false,
          );
          loading = false;
        } else if (msg == 'Please verifiy your email first') {
          loading = false;
          Toast.show("Kindly verify your Email Address ", context,
              gravity: Toast.BOTTOM, duration: 3);
        } else if (success == '0') {
          loading = false;
          Toast.show("Error Signing in, check email and password", context,
              gravity: Toast.BOTTOM, duration: 3);
        }
      });
    });
  }

  bool checklogin() {
    return usersession = sessionBox.get(usersessionkey, defaultValue: false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!checklogin()) {
      print("Not logged in");
    }
  }

  @override
  Widget build(BuildContext context) {
    return checklogin() ? userprofile() : loginui(context);
  }

  Widget loginui(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset("images/sbazar_icon.jpeg",
                    width: MediaQuery.of(context).size.width * .25,
                    height: MediaQuery.of(context).size.height * .25,),
                  SizedBox(
                    height: 10,
                  ),
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
                  SizedBox(
                    height: 10,
                  ),
                  DarkTextField(
                    hasfocus: true,
                    obscuretext: true,
                    inputtype: TextInputType.text,
                    labeltext: "Password",
                    hintext: "Enter Password",
                    onChanged: (String getPass) {
                      password = getPass;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Material(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>forgotpasspage()
                        ));
                      },
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                            color: mainaccent,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RoundButton(
                    textval: 'Sign In',
                    onpress: () {
                      setState(() {
                        FocusScope.of(context).unfocus();
                        if (email == null && password == null) {
                          showAlertDialog(
                              context: context,
                              content: 'Kindly fill the form');
                        } else {
                          customer_login_model clogin_model =
                              customer_login_model(
                            email: email,
                            password: password,
                          );
                          loading = true;
                          loginuser(clogin_model, context);
                        }
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'OR',
                    textAlign: TextAlign.center,
                    style: TextStyleFormBlack,
                  ),
                  //SOCIAL LOGINS
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //FACEBOOK
                      ClipOval(
                        child: Material(
                          color: Colors.blue, // button color
                          child: InkWell(
                            splashColor: mainaccent, // inkwell color
                            child: SizedBox(
                                width: 50,
                                height: 50,
                                child: Icon(
                                  FontAwesomeIcons.facebookF,
                                  color: Colors.white,
                                )),
                            onTap: () {
                              setState(() {
                                _login();
                              });
                            },
                          ),
                        ),
                      ),

                      SizedBox(
                        width: 30,
                      ),
                      //GOOGLE
                      ClipOval(
                        child: Material(
                          color: Colors.red, // button color
                          child: InkWell(
                            splashColor: Colors.amber, // inkwell color
                            child: SizedBox(
                                width: 50,
                                height: 50,
                                child: Icon(
                                  FontAwesomeIcons.google,
                                  color: Colors.white,
                                )),
                            onTap: () {},
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? ",
                          style: TextStyle(color: Color(0xFF656565), fontSize: 16)),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()));
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: mainaccent,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    try {
      // show a circular progress indicator
//      setState(() {
//        _checking = true;
//      });
      _accessToken = await FacebookAuth.instance.login(); // by the fault we request the email and the public profile
      // loginBehavior is only supported for Android devices, for ios it will be ignored
      // _accessToken = await FacebookAuth.instance.login(
      //   permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],
      //   loginBehavior:
      //       LoginBehavior.DIALOG_ONLY, // (only android) show an authentication dialog instead of redirecting to facebook app
      // );
//      _printCredentials();
      print("****accesstoken****"+_accessToken.toJson().toString());
      // get the user data
      // by default we get the userId, email,name and picture
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _userData = userData;
    } on FacebookAuthException catch (e) {
      // if the facebook login fails
      print(e.message); // print the error message in console
      // check the error type
      switch (e.errorCode) {
        case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
          print("You have a previous login operation in progress");
          break;
        case FacebookAuthErrorCode.CANCELLED:
          print("login cancelled");
          break;
        case FacebookAuthErrorCode.FAILED:
          print("login failed");
          break;
      }
    } catch (e, s) {
      // print in the logs the unknown errors
      print(e);
      print(s);
    } finally {
//      // update the view
//      setState(() {
//        _checking = false;
//      });
    }
  }


  Future<void> _logOut() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
    setState(() {});
  }

}
