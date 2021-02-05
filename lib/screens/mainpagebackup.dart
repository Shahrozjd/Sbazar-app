//import 'package:badges/badges.dart';
//import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:hive/hive.dart';
//import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
//import 'package:sbazarapp/components/carticon.dart';
//import 'package:sbazarapp/components/constants.dart';
//import 'package:sbazarapp/components/footer.dart';
//import 'package:sbazarapp/models/bottombarModel.dart';
//import 'package:sbazarapp/models/menubarModel.dart';
//import 'package:sbazarapp/screens/Account.dart';
//import 'package:sbazarapp/screens/BottomNav.dart';
//import 'package:sbazarapp/screens/Navdrawer.dart';
//import 'package:sbazarapp/screens/cartpage.dart';
//import 'package:sbazarapp/screens/homepage.dart';
//import 'package:sbazarapp/services/bottombarServices.dart';
//import 'package:sbazarapp/services/menubarServices.dart';
//
//class mainpage extends StatefulWidget {
//  @override
//  _mainpageState createState() => _mainpageState();
//}
//
//class _mainpageState extends State<mainpage> {
//  Box<int> cartcountbox = Hive.box('cart_count');
//  int cartcountkey = 102;
//  int cartcount;
//
//  String greeting() {
//    var hour = DateTime.now().hour;
//    if (hour < 12) {
//      return 'Good Morning ☀';
//    }
//    if (hour < 17) {
//      return 'Good Afternoon 🌗';
//    }
//    return 'Good Evening 🌑';
//  }
//
//  Future<List<menubarModel>> menubarfuture;
//
//  @override
//  void initState() {
//    cartcount = cartcountbox.get(cartcountkey, defaultValue: 0);
//    menubarfuture = menubarServices().getMenubar();
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        drawer: navdrawer(),
//        bottomNavigationBar: null,
//        body: Column(
//          children: [
//            //upper container with background
//            FutureBuilder(
//              future: menubarfuture,
//              builder: (context, snapshot) {
//                String image_string = menubarServices.image_string;
//                if (snapshot.hasData) {
//                  return Expanded(
//                    flex: 7,
//                    child: Container(
//                      padding: EdgeInsets.only(
//                          top: 50, left: 20, right: 20, bottom: 20),
//                      decoration: BoxDecoration(
//                        image: DecorationImage(
//                          image: NetworkImage(
//                              "http://www.sbazar.gmbh/public/storage/app/welcome/" +
//                                  image_string),
//                          fit: BoxFit.cover,
//                          colorFilter: ColorFilter.mode(
//                              Colors.black.withOpacity(0.2), BlendMode.darken),
//                        ),
//                        borderRadius: BorderRadius.only(
//                          bottomRight: Radius.elliptical(700, 400),
//                          bottomLeft: Radius.elliptical(400, 100),
//                        ),
//                      ),
//                      child: Column(
//                        children: [
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: [
//                              //Good Morning Message
//                              Text(
//                                greeting(),
//                                style: TextStyleHeadingBold,
//                              ),
//
//                              ClipOval(
//                                child: Material(
//                                  child: InkWell(
//                                    splashColor: Colors.black.withOpacity(0.4),
//                                    onTap: () {
//                                      Navigator.push(
//                                          context,
//                                          MaterialPageRoute(
//                                              builder: (context) => account()));
//                                    },
//                                    child: Container(
//                                        padding: EdgeInsets.all(10),
//                                        child: Icon(FontAwesomeIcons.user)),
//                                  ),
//                                ),
//                              )
//                            ],
//                          ),
//                          SizedBox(
//                            height: 10,
//                          ),
//                          Divider(
//                            color: Colors.black,
//                            height: 5,
//                          ),
//                          ListView.builder(
//                            primary: false,
//                            shrinkWrap: true,
//                            itemCount: snapshot.data.length,
//                            itemBuilder: (context, index) {
//                              menubarModel menubarmodel = snapshot.data[index];
//                              return mainpageheadercards(
//                                title: menubarmodel.title,
//                                desc: "",
//                                imagepath:
//                                "http://www.sbazar.gmbh/public/storage/app/backgrounds/" +
//                                    menubarmodel.bg_image,
//                                ontap: () {
//                                  if (menubarmodel.title == 'Groceries') {
//                                    Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                        builder: (context) =>
//                                            PersistentBottomBar(),
//                                      ),
//                                    );
//                                  }
//                                },
//                              );
//                            },
//                          ),
//                        ],
//                      ),
//                    ),
//                  );
//                }
//                return Container();
//              },
//            ),
//            Expanded(
//              flex: 3,
//              child: Container(
//                alignment: Alignment.center,
//                child: ListView(
//                  primary: false,
//                  shrinkWrap: true,
//                  children: [
//                    bottomListTiles(
//                      title: "Sbazar Coupons",
//                      icondata: FontAwesomeIcons.coins,
//                    ),
//                    Divider(
//                      height: 5,
//                      color: Colors.grey,
//                    ),
//                    bottomListTiles(
//                      title: "More",
//                      icondata: Icons.more_horiz,
//                      onTap: () {
//                        mainpageBottomModal(context: context);
//                      },
//                    ),
//                  ],
//                ),
//              ),
//            )
//          ],
//        ));
//  }
//
//  Future<dynamic> mainpageBottomModal({BuildContext context}) {
//    return showModalBottomSheet(
//        backgroundColor: Colors.transparent,
//        context: context,
//        builder: (context) {
//          return Container(
//            height: MediaQuery.of(context).size.height * 0.75,
//            decoration: BoxDecoration(
//                color: Color(0xFFFAFAFA),
//                borderRadius: new BorderRadius.only(
//                    topLeft: const Radius.circular(40.0),
//                    topRight: const Radius.circular(40.0))),
//            child: SingleChildScrollView(
//              child: Container(
//                padding: EdgeInsets.all(20),
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.stretch,
//                  children: [
//                    Text(
//                      "More",
//                      style: TextStyleFormBlack,
//                      textAlign: TextAlign.center,
//                    ),
//                    SizedBox(
//                      height: 15,
//                    ),
//                    Text("Support", style: TextStyleMediumBlackBold),
//                    Divider(
//                      color: Colors.grey,
//                    ),
//                    for (int i = 0; i < 3; i++)
//                      ListTile(
//                        focusColor: mainaccent,
//                        title: Text(
//                          "Example",
//                          style: TextStyleFormBlack,
//                        ),
//                        trailing: Icon(Icons.arrow_forward),
//                        onTap: () {},
//                      ),
//                    Divider(
//                      color: Colors.grey,
//                    ),
//                    Text("Information", style: TextStyleMediumBlackBold),
//                    Divider(
//                      color: Colors.grey,
//                    ),
//                    for (int i = 0; i < 3; i++)
//                      ListTile(
//                        focusColor: mainaccent,
//                        title: Text(
//                          "Example",
//                          style: TextStyleFormBlack,
//                        ),
//                        trailing: Icon(Icons.arrow_forward),
//                        onTap: () {},
//                      ),
//                    Divider(
//                      color: Colors.grey,
//                    ),
//                    Text("App Settings", style: TextStyleMediumBlackBold),
//                    Divider(
//                      color: Colors.grey,
//                    ),
//                    for (int i = 0; i < 3; i++)
//                      ListTile(
//                        focusColor: mainaccent,
//                        title: Text(
//                          "Example",
//                          style: TextStyleFormBlack,
//                        ),
//                        trailing: Icon(Icons.arrow_forward),
//                        onTap: () {},
//                      ),
//                    Divider(
//                      color: Colors.grey,
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          );
//        });
//  }
//}
//
//class bottomListTiles extends StatelessWidget {
//  String title;
//  IconData icondata;
//  Function onTap;
//
//  bottomListTiles({this.title, this.icondata, this.onTap});
//
//  @override
//  Widget build(BuildContext context) {
//    return ListTile(
//      onTap: onTap,
//      title: Text(
//        title,
//        style: TextStyleFormBlack,
//      ),
//      leading: Icon(icondata),
//    );
//  }
//}
//
//class bottomListTilesIMG extends StatelessWidget {
//  String title;
//  String image_string;
//  Function onTap;
//
//  bottomListTilesIMG({this.title, this.image_string, this.onTap});
//
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      children: [
//        ListTile(
//          onTap: onTap,
//          title: Text(
//            title,
//            style: TextStyleFormBlack,
//          ),
//          leading: Image.network(image_string),
//        ),
//        Divider(
//          color: Colors.grey,
//        )
//      ],
//    );
//  }
//}
//
//class mainpageheadercards extends StatelessWidget {
//  String title;
//  String desc;
//  String imagepath;
//  Function ontap;
//
//  mainpageheadercards({this.title, this.desc, this.imagepath, this.ontap});
//
//  @override
//  Widget build(BuildContext context) {
//    return InkWell(
//      onTap: ontap,
//      child: Container(
//        margin: EdgeInsets.only(bottom: 10),
//        padding: EdgeInsets.all(10),
//        height: 110.0,
//        decoration: new BoxDecoration(
//            borderRadius: BorderRadius.circular(15),
//            color: Colors.grey.shade200.withOpacity(0.90)),
//        child: Row(
//          children: [
//            Expanded(
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.stretch,
//                children: [
//                  Text(
//                    title,
//                    style: TextStyleFormBlackBold,
//                  ),
//                  Text(
//                    desc,
//                    style: TextStyleFormBlack,
//                  )
//                ],
//              ),
//            ),
//            SizedBox(
//              width: 10,
//            ),
//            Container(
//              width: 80.0,
//              height: 80.0,
//              decoration: new BoxDecoration(
//                shape: BoxShape.rectangle,
//                borderRadius: BorderRadius.circular(10),
//                image: new DecorationImage(
//                  fit: BoxFit.cover,
//                  image: NetworkImage(imagepath),
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
