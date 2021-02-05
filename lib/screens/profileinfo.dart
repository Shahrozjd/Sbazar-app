import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sbazarapp/components/DarkTextField.dart';
import 'package:sbazarapp/components/RectButton.dart';
import 'package:sbazarapp/components/constants.dart';
import 'package:sbazarapp/models/userprofile_model.dart';
import 'package:sbazarapp/screens/updatepass.dart';
import 'package:sbazarapp/services/userprofile_services.dart';
import 'package:toast/toast.dart';

class profileinfo extends StatefulWidget {
  String email;

  profileinfo({this.email});

  @override
  _profileinfoState createState() => _profileinfoState(email);
}

class _profileinfoState extends State<profileinfo>
    with TickerProviderStateMixin {

  var fnamecontroller = TextEditingController();
  var lnamecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var gendercontroller = TextEditingController();
  String email;
  String formattedDate;
  DateTime selectedDate = DateTime.now();
  Future<userprofile_model> userprof_future;

  _profileinfoState(this.email);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
  }

  getProfileInfo(userprofile_model userprof) {
    userprof_future = userprofile_services().getUserProfile(userprof);
  }

  add(userprofile_model userprof) async {
    await userprofile_services().UpdateUserProfile(userprof).then((value){
      final body = json.decode(value);
      print(body['data'].toString());
      final int success = (body['success']);
      setState(() {
        if(success == 1)
        {
          Toast.show("Profile Updated Successfully", context,gravity: Toast.BOTTOM,duration: 3);
          setState(() {
            userprofile_model userprof = userprofile_model(email: email);
            print("check initstate");
            getProfileInfo(userprof);
          });
        }
        else{

          Toast.show("Error Updating Profile Info", context,gravity: Toast.BOTTOM,duration: 3);
        }
      });
    });
  }


  @override
  void initState() {
    userprofile_model userprof = userprofile_model(email: email);
    print("check initstate");
    getProfileInfo(userprof);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    return Scaffold(
      appBar: AppBar(title: Text("Profile Info")),
      body: FutureBuilder(
        future: userprof_future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            userprofile_model userprof = snapshot.data;
            fnamecontroller.text = userprof.first_name.toString();
            lnamecontroller.text = userprof.last_name.toString();
            phonecontroller.text = userprof.phone.toString();
            gendercontroller.text = userprof.gender.toString();
            email = userprof.email;
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Color(0xFFF1F1F1),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        )
                      ]),
                  child: Wrap(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text("Firstname", style: TextStyleFormBlack),
                                    DarkTextField(
                                      hasfocus: true,
                                      controller: fnamecontroller,
                                      obscuretext: false,
                                      inputtype: TextInputType.text,
                                      onChanged: (String getName) {},
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text("Lastname", style: TextStyleFormBlack),
                                    DarkTextField(
                                      hasfocus: true,
                                      controller: lnamecontroller,
                                      obscuretext: false,
                                      inputtype: TextInputType.text,
                                      onChanged: (String getName) {},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Phone", style: TextStyleFormBlack),
                          DarkTextField(
                            hasfocus: true,
                            controller: phonecontroller,
                            obscuretext: false,
                            inputtype: TextInputType.text,
                            onChanged: (String getName) {},
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Email", style: TextStyleFormBlack),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            userprof.email,
                            style: TextStyleFormBlack,
                          ),
                          Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Gender", style: TextStyleFormBlack),
                          DarkTextField(
                            hasfocus: true,
                            controller: gendercontroller,
                            obscuretext: false,
                            onChanged: (String getName) {},
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Date of Birth",
                            style: TextStyleFormBlack,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  _selectDate(context);
                                });
                              },
                              splashColor: mainaccent.withOpacity(0.2),
                              child: Text(
                                formattedDate.toString(),
                                style: TextStyleFormBlack,
                              )),
                          Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Refferal ID", style: TextStyleFormBlack),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            userprof.referral_id,
                            style: TextStyleFormBlack,
                          ),
                          Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RectButton(
                            textval: 'Update',
                            onpress: () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                print(phonecontroller.text);
                                userprofile_model userprof = userprofile_model(
                                  email: email,
                                  first_name: fnamecontroller.text,
                                  last_name: lnamecontroller.text,
                                  phone: phonecontroller.text,
                                  gender: gendercontroller.text,
                                  dob: formattedDate.toString(),
                                );
                                add(userprof);
                              });
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RectButton(
                            textval: 'Change Password',
                            onpress: (){
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>updatepasspage(
                                  email: email,
                                )
                              ));
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Material(
                            elevation: 5,
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: InkWell(
                              onTap: (){

                              },
                              splashColor: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: Container(
                                height: 50,
                                alignment: Alignment.center,
                                child: Text("ADDRESS INFO",style: TextStyleFormBlack,),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return Center(
            child: SpinKitFadingCircle(
              color: mainaccent,
              size: 50.0,
              controller: AnimationController(
                  vsync: this, duration: const Duration(milliseconds: 1200)),
            ),
          );
        },
      ),
    );



  }
}
