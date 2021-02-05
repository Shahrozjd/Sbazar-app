import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sbazarapp/components/constants.dart';
import 'package:sbazarapp/models/userprofile_model.dart';
import 'package:sbazarapp/screens/Account.dart';
import 'package:sbazarapp/screens/BottomNav.dart';
import 'package:sbazarapp/screens/favitems.dart';
import 'package:sbazarapp/screens/mainpage.dart';
import 'package:sbazarapp/screens/profileinfo.dart';
import 'package:sbazarapp/services/userprofile_services.dart';

class userprofile extends StatefulWidget {
  String email;


  userprofile({this.email});

  @override
  _userprofileState createState() => _userprofileState(email);
}

class _userprofileState extends State<userprofile> with TickerProviderStateMixin{
  String email;
  Box sessionBox = Hive.box('logincheck');
  Box<int> cartitemsBox = Hive.box('cart_items');
  Box<int> cartcountBox = Hive.box('cart_count');
  Box pointBox = Hive.box('pointdata');
  Box<bool> addedproductBox = Hive.box('added_product');
  Box<bool> favproductBox = Hive.box('favproducts');
  Box<int> productquantBox = Hive.box('added_product_quant');

  int usersessionkey = 100;
  int useremailkey = 101;
  String useremail;
  bool usersession;

  _userprofileState(this.email);

  String firstname,lastname,spoints,ppoints;

  Future<userprofile_model> userprofobj;

  getuserprofile(userprofile_model userprof)
  {
      userprofobj = userprofile_services().getUserProfile(userprof);
  }

  @override
  void initState() {
    print(email);
    if(email == null)
    {
      email = sessionBox.get(useremailkey,defaultValue: null);
      print("frombox"+email.toString());
    }
    userprofile_model userprof = userprofile_model(email: email);
    getuserprofile(userprof);
    super.initState();


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: (){
                  sessionBox.clear();
                  cartcountBox.clear();
                  cartitemsBox.clear();
                  pointBox.clear();
                  addedproductBox.clear();
                  favproductBox.clear();
                  productquantBox.clear();
                  pushNewScreen(context, screen: mainpage(),withNavBar: false);
              },
              splashColor: Colors.white.withOpacity(0.2),
              icon : Icon(FontAwesomeIcons.signOutAlt),
            ),
          )
        ],
        title: Text('Profile'),
        backgroundColor: mainaccent,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: userprofobj,
        builder: (context,snapshot){
          print(snapshot.data.toString());
          if(snapshot.hasData)
            {
              userprofile_model userprof = snapshot.data;
              return SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        height: 150,
                        decoration: BoxDecoration(
                            color: mainaccent,
                            borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(50))),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 55,
                              backgroundImage: AssetImage("images/profile_sample.jpg"),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              userprof.first_name+" "+userprof.last_name,
                              style: TextStyleHeading,
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: mainaccent,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.only(topRight: Radius.circular(50))),
                          child: Column(
                            children: [
                              //SPOINT AND PREMIUM POINTS
                              Container(
                                height: 80,
                                decoration: BoxDecoration(
                                    color: Color(0xFFF1F1F1),
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.7),
                                        spreadRadius: 2,
                                        blurRadius: 3,
                                        offset: Offset(0, 3),
                                      )
                                    ]),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              userprof.spoints.toString(),
                                              style: TextStyleHeadingAccentBold,
                                            ),
                                            Text("Spoints",
                                                style: TextStyleMediumBlackBold)
                                          ],
                                        ),
                                      ),
                                    ),
                                    VerticalDivider(
                                      width: 10,
                                      thickness: 2,
                                      color: mainaccent,
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              userprof.ppoints.toString(),
                                              style: TextStyleHeadingAccentBold,
                                            ),
                                            Text("Premium",
                                                style: TextStyleMediumBlackBold),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              profilecard(
                                ontap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => profileinfo(email:userprof.email.toString()),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(FontAwesomeIcons.infoCircle,
                                            size: 30, color: mainaccent),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Profile Info",
                                          style: TextStyleHeadingBlack,
                                        ),
                                      ],
                                    ),
                                    Icon(FontAwesomeIcons.arrowRight),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              profilecard(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(FontAwesomeIcons.receipt,
                                            size: 30, color: mainaccent),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Invoices",
                                          style: TextStyleHeadingBlack,
                                        ),
                                      ],
                                    ),
                                    Icon(FontAwesomeIcons.arrowRight),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              profilecard(
                                ontap: (){

                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(FontAwesomeIcons.pager,
                                            size: 30, color: mainaccent),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Referrals & Users",
                                          style: TextStyleHeadingBlack,
                                        ),
                                      ],
                                    ),
                                    Icon(FontAwesomeIcons.arrowRight),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              profilecard(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.star,
                                          size: 30,
                                          color: mainaccent,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Reviews",
                                          style: TextStyleHeadingBlack,
                                        ),
                                      ],
                                    ),
                                    Icon(FontAwesomeIcons.arrowRight),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              profilecard(
                                ontap: (){
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) => favitemspage()));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.heart,
                                          size: 30,
                                          color: mainaccent,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Wishlist",
                                          style: TextStyleHeadingBlack,
                                        ),
                                      ],
                                    ),
                                    Icon(FontAwesomeIcons.arrowRight),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              profilecard(
                                ontap: (){

                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.coins,
                                          size: 30,
                                          color: mainaccent,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Sbazar Coupons",
                                          style: TextStyleHeadingBlack,
                                        ),
                                      ],
                                    ),
                                    Icon(FontAwesomeIcons.arrowRight),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              profilecard(
                                ontap: (){
                                  mainpageBottomModal(context: context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.list,
                                          size: 30,
                                          color: mainaccent,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "More",
                                          style: TextStyleHeadingBlack,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          return Center(
            child: SpinKitFadingCircle(
              color: mainaccent,
              size: 50.0,
              controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
            ),);
        },
      ),
    );
  }

  Future<dynamic> mainpageBottomModal({BuildContext context}) {
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
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "More",
                      style: TextStyleFormBlack,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text("Support", style: TextStyleMediumBlackBold),
                    Divider(
                      color: Colors.grey,
                    ),
                    for (int i = 0; i < 3; i++)
                      ListTile(
                        focusColor: mainaccent,
                        title: Text(
                          "Example",
                          style: TextStyleFormBlack,
                        ),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {},
                      ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Text("Information", style: TextStyleMediumBlackBold),
                    Divider(
                      color: Colors.grey,
                    ),
                    for (int i = 0; i < 3; i++)
                      ListTile(
                        focusColor: mainaccent,
                        title: Text(
                          "Example",
                          style: TextStyleFormBlack,
                        ),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {},
                      ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Text("App Settings", style: TextStyleMediumBlackBold),
                    Divider(
                      color: Colors.grey,
                    ),
                    for (int i = 0; i < 3; i++)
                      ListTile(
                        focusColor: mainaccent,
                        title: Text(
                          "Example",
                          style: TextStyleFormBlack,
                        ),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {},
                      ),
                    Divider(
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

}

class profilecard extends StatelessWidget {
  Widget child;
  Function ontap;

  profilecard({this.child, this.ontap});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        onTap: ontap,
        splashColor: mainaccent.withOpacity(0.2 ),
        child: Container(
          padding: EdgeInsets.all(15),
          height: 60,
          decoration: BoxDecoration(
              color: Color(0xFFF1F1F1),
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 3),
                )
              ]),
          child: child,
        ),
      ),
    );
  }



}

