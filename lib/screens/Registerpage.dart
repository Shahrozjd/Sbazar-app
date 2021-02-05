import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:hive/hive.dart';
import 'package:html/parser.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sbazarapp/components/AlertDialog.dart';
import 'package:sbazarapp/components/DarkTextField.dart';
import 'package:sbazarapp/components/RectButton.dart';
import 'package:sbazarapp/components/RoundButton.dart';
import 'package:sbazarapp/components/constants.dart';
import 'package:sbazarapp/components/customloading.dart';
import 'package:sbazarapp/main.dart';
import 'package:sbazarapp/models/customer_registeration_model.dart';
import 'package:sbazarapp/models/termsandpolicyModel.dart';
import 'package:sbazarapp/screens/Account.dart';
import 'package:sbazarapp/screens/userprofile.dart';
import 'package:sbazarapp/services/customer_registeration_services.dart';
import 'package:sbazarapp/services/termsandpolicyServices.dart';
import 'package:toast/toast.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool checkconsent = false;
  bool checkref = false;

  bool loading = false;
  String firstname, lastname, email, password, phone, refid;



  add(customer_registeration_model creg_model) async {
    await customer_registeration_services()
        .RegisterCustomer(creg_model)
        .then((value) {
      final body = json.decode(value);
      final String success = (body['success']);
      final String message = body['message'];
      setState(() {
        print("kaboom");
        if (success == '1') {
          Toast.show("Registration Successful, Verification sent to your Email",
              context,
              gravity: Toast.BOTTOM, duration: 4);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => account(),
            ),
          );
          loading = false;
        } else if (success == '0') {
          loading = false;
          Toast.show("This account already exist", context,
              gravity: Toast.BOTTOM, duration: 3);
        } else if (message == 'invalid referral code'){
          loading = false;
          Toast.show("Registration Failed, Invalid Refferal code", context,
              gravity: Toast.BOTTOM, duration: 3);
        }
        else {
          loading = false;
          print("error");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Register',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
//                  Image.asset("images/sbazar_navheader.png",width: 100,height: 100,),
//                  SizedBox(
//                    height: 10,
//                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DarkTextField(
                        hasfocus: true,
                        obscuretext: false,
                        inputtype: TextInputType.name,
                        labeltext: 'FirstName',
                        hintext: 'Enter your FirstName',
                        onChanged: (String getFname) {
                          firstname = getFname;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: DarkTextField(
                        hasfocus: true,
                        obscuretext: false,
                        inputtype: TextInputType.name,
                        labeltext: 'LastName',
                        hintext: 'Enter your LastName',
                        onChanged: (String getLname) {
                          lastname = getLname;
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 10,
                ),
                DarkTextField(
                  hasfocus: true,
                  obscuretext: false,
                  inputtype: TextInputType.emailAddress,
                  labeltext: 'Email',
                  hintext: 'Enter your Email',
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
                  labeltext: 'Password',
                  hintext: 'Enter your Password(min. 8 char)',
                  onChanged: (String getPassword) {
                    password = getPassword;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                DarkTextField(
                  hasfocus: true,
                  obscuretext: false,
                  inputtype: TextInputType.number,
                  labeltext: 'Phone',
                  hintext: 'Enter your Phone',
                  onChanged: (String getPhone) {
                    phone = getPhone;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Checkbox(
                      onChanged: (bool value) {
                        setState(() {
                          checkref = value;
                          if(!checkref)
                            {
                              refid = null;
                            }
                        });
                      },
                      value: checkref,
                      activeColor: mainaccent,
                    ),
                    Text(
                      'I have Refferal ID',
                      style: TextStyleFormBlack,
                    )
                  ],
                ),
                //for refferal id
                Visibility(
                  visible: checkref,
                  child: DarkTextField(
                    hasfocus: true,
                    obscuretext: false,
                    inputtype: TextInputType.text,
                    labeltext: "Refferal ID",
                    onChanged: (String getrefid) {
                      refid = getrefid;
                    },
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      onChanged: (bool value) {
                        setState(() {
                          checkconsent = value;
                        });
                      },
                      value: checkconsent,
                      activeColor: mainaccent,
                    ),
                    Row(
                      children: [
                        Text('I accept ',style: TextStyleFormBlack,),
                        InkWell(
                          onTap: () {
                            conditionModal(context, termsandpolicyServices().getterms());
                          },
                          child: Text(
                            'Term & Conditions',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: mainaccent,
                            ),
                          ),
                        ),
                        Text(' / '),
                        InkWell(
                          onTap: () {
                            conditionModal(context, termsandpolicyServices().getprivacy());
                          },
                          child: Text(
                            'Privacy Policy',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: mainaccent,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                RoundButton(
                  textval: 'Register',
                  height: 40,
                  onpress: () {
                    setState(() {
                      FocusScope.of(context).unfocus();
                      if (firstname == null &&
                          lastname == null &&
                          email == null &&
                          password == null &&
                          phone == null) {
                        showAlertDialog(
                            context: context,
                            content: 'Please fill all the fields');
                      }
                      if (!checkconsent) {
                        showAlertDialog(
                            context: context,
                            content:
                                'Kindly accept Term Conditions & Privacy Policy');
                      } else {

                        bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

                        if(emailValid)
                          {
                            if(refid == null)
                            {
                              customer_registeration_model creg_model =
                              customer_registeration_model(
                                  customers_firstname: firstname,
                                  customers_lastname: lastname,
                                  email: email,
                                  password: password,
                                  customers_telephone: phone.toString(),
                                  ref_id: ""
                              );
                              loading = true;
                              add(creg_model);
                            }
                            else
                            {
                              customer_registeration_model creg_model =
                              customer_registeration_model(
                                customers_firstname: firstname,
                                customers_lastname: lastname,
                                email: email,
                                password: password,
                                customers_telephone: phone.toString(),
                                ref_id: refid,
                              );
                              loading = true;
                              add(creg_model);
                            }
                          }
                        else
                          {
                            Toast.show("Kindly Add Valid email Address",
                                context,
                                gravity: Toast.BOTTOM, duration: 4);
                          }




                      }
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("OR ",
                        style: TextStyle(color: Colors.black, fontSize: 18)),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => account()));
                        },
                        child: Text(
                          "Login to your Account",
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
    );
  }

  Future<dynamic> conditionModal(BuildContext context, Future getfuture) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: BoxDecoration(
                color: Color(0xFFFAFAFA),
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(40.0),
                    topRight: const Radius.circular(40.0))),
            child: FutureBuilder(
              future: getfuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  termsandpolicyModel model = snapshot.data;
                  final document = parse(model.description.toString());
                  final String parsed_prod_desc = parse(document.body.text).documentElement.text;
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            model.name,
                            style: TextStyleFormBlackBold,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            parsed_prod_desc,
                            style: TextStyleFormBlack,
                          )
                        ],
                      ),
                    ),
                  );
                }
                return customloading();
              },
            ),
          );
        });
  }



}
