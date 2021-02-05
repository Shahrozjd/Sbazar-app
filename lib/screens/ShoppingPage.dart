import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:sbazarapp/components/MainAppbBar.dart';
import 'package:sbazarapp/components/buildAppbar.dart';
import 'package:sbazarapp/components/carticon.dart';
import 'package:sbazarapp/components/constants.dart';
import 'package:sbazarapp/screens/Navdrawer.dart';
import 'package:sbazarapp/screens/ProductListing.dart';
import 'package:sbazarapp/models/categoriesmodel.dart';
import 'package:sbazarapp/screens/homepage.dart';
import 'package:sbazarapp/services/categoriesservices.dart';

class shoppingpage extends StatefulWidget {
  @override
  _shoppingpageState createState() => _shoppingpageState();
}

class _shoppingpageState extends State<shoppingpage>
    with TickerProviderStateMixin {
  Future<List<categoriesmodel>> categorieslist;

//  Box<int> cartcountbox = Hive.box('cart_count');
//  int cartcountkey = 102;
//  int cartcount;

  Box pointbox = Hive.box('pointdata');
  int pointboxkeypoint = 105;
  int point;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getting cart count
//    cartcount = cartcountbox.get(cartcountkey,defaultValue: 0);
    categorieslist = categoriesservices().getCategories();

    //getting points data
    point = pointbox.get(pointboxkeypoint, defaultValue: 0);
  }

  Future<bool> _onWillPop() async {
    Navigator.pop(context);
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => homepage()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        appBar: MainAppbar(
          appBar: AppBar(),
          point: point,
        ),
        body: Container(
          padding: EdgeInsets.only(left: 5,right: 5,bottom: 5,top: 10),
          child: FutureBuilder<List<categoriesmodel>>(
            future: categorieslist,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  itemCount: snapshot.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    categoriesmodel categ = snapshot.data[index];
                    return gridcards(
                      title: categ.categories_name,
                      imagepath:
                          'http://www.sbazar.gmbh/public/images/media/2021/01/' +
                              categ.icon_of_category.toString(),
                      ontap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductListing(
                              apptitle: categ.categories_name.toString(),
                              parentid: categ.categories_id.toString(),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                    child: Text(
                  "Oops some error has occured",
                  style: TextStyleMediumBlack,
                ));
              }
              return Center(
                child: SpinKitFadingCircle(
                  color: mainaccent,
                  size: 50.0,
                  controller: AnimationController(
                      vsync: this,
                      duration: const Duration(milliseconds: 1200)),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class gridcards extends StatelessWidget {
  String imagepath;
  String title = "title";
  Function ontap;

  gridcards({this.imagepath, this.title, this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: mainaccent.withOpacity(0.2),
      onTap: ontap,
      child: Container(
//        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 7,
              child: Image.network(imagepath),
            ),
            SizedBox(height: 10,),
            Expanded(
              flex: 3,
              child: Text(title,style: TextStyleFormBlackBold,textAlign: TextAlign.center,),
            )
          ],
        ),
      ),
    );
  }
}
