import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:sbazarapp/components/RectButton.dart';
import 'package:sbazarapp/components/RectButtonAlt.dart';
import 'package:sbazarapp/components/carticon.dart';
import 'package:sbazarapp/components/constants.dart';
import 'package:sbazarapp/components/footer.dart';
import 'package:sbazarapp/components/productcard.dart';
import 'package:sbazarapp/models/childcategoriesmodel.dart';
import 'package:sbazarapp/models/productmodel.dart';
import 'package:sbazarapp/screens/Navdrawer.dart';
import 'package:sbazarapp/screens/ShoppingPage.dart';
import 'package:sbazarapp/screens/mainpage.dart';
import 'package:sbazarapp/services/childcategoriesservices.dart';
import 'package:sbazarapp/services/productservices.dart';
import 'package:html/parser.dart';


ProductListingState productListingState;
class ProductListing extends StatefulWidget {
  String apptitle;
  String parentid;

  ProductListing({this.apptitle, this.parentid});

  @override
  ProductListingState createState(){
    productListingState =  ProductListingState(apptitle, parentid);
    return productListingState;
  }
}

class ProductListingState extends State<ProductListing>
    with TickerProviderStateMixin {
  String apptitle;
  String parentid;

  ProductListingState(this.apptitle, this.parentid);



  int amount = 1;
  int _startingTabCount = 0;
  List<Tab> _tabs = List<Tab>();
  List<Widget> _generalWidgets = List<Widget>();
  TabController _tabController;

  Future<List<childcategoriesmodel>> childcategorieslist;
  Future<List<productmodel>> productlist;

//  Box<int> cartcountbox = Hive.box('cart_count');
//  int cartcountkey = 102;
//  int cartcount;

  Box<bool> productbox = Hive.box('added_product');
  Box<int> productbox_quant = Hive.box('added_product_quant');
  Box<bool> favproductbox = Hive.box('favproducts');
  bool isfav;
  int isfavkey = 103;


//  bool footervis;
//  int footerpoints;
//  double footersave;
//  Box footerbox = Hive.box('footerdata');
//  int footerboxkeypoint = 105;
//  int footerboxkeysave = 106;
//  int footerboxkeyvisibility = 107;

  @override
  void initState() {
    childcategorieslist = childcategoriesservices().getCategories(parentid);
//    cartcount = cartcountbox.get(cartcountkey,defaultValue: 0);

    //getting footer data
//    footervis = footerbox.get(footerboxkeyvisibility,defaultValue: false);
//    footerpoints = footerbox.get(footerboxkeypoint,defaultValue: 0);
//    footersave = footerbox.get(footerboxkeysave,defaultValue: 0.0);
    super.initState();
  }

  //SHOW ALL WIDGETS and get snapshot for category id
  List<Widget> getWidgets(AsyncSnapshot snapshot) {
    _generalWidgets.clear();
    for (int i = 0; i < _tabs.length; i++) {
      childcategoriesmodel childcateg = snapshot.data[i];
      productlist =
          productservices().getProduct(childcateg.categories_id.toString());
      _generalWidgets.add(
        FutureBuilder(
          future: productlist,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.55,
                ),
                itemBuilder: (context, index) {
                  productmodel product = snapshot.data[index];
                  bool enableadder = productbox.get(product.products_id,defaultValue: false);
                  int productquant = productbox_quant.get(product.products_id,defaultValue: 0);
                  String productdesc_html = product.products_description;
                  isfav = favproductbox.get(product.products_id,defaultValue: false);
                  final document = parse(productdesc_html);
                  final String parsed_prod_desc = parse(document.body.text).documentElement.text;

                  return productcard(
                    title: product.products_name.toString(),
                    weight: product.products_weight +
                        " " +
                        product.products_weight_unit,
                    price: product.products_price,
                    imagepath:
                        'http://www.sbazar.gmbh/public/images/media/2020/12/' +
                            product.image_of_product.toString(),
                    product_id: product.products_id,
                    marketprice: product.products_price_market.toString(),
                    productpoints: product.products_points.toString(),
                    productstatus: product.products_status,
                    enabeladder: enableadder,
                    productquantitiy: enableadder?productquant:1,
                    productdesc: parsed_prod_desc,
                    productsku: product.products_sku,
                    isfav: isfav,
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
                controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
              ),);
          },
        ),
      );
    }
    return _generalWidgets;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabs.length = 0;
    super.dispose();
  }

  //usign snapshot here to get titles for each tab

  List<Tab> getTabs(int count, AsyncSnapshot snapshot) {
    _tabs.clear();
    for (int i = 0; i < count; i++) {
      childcategoriesmodel childcateg = snapshot.data[i];
      _tabs.add(getTab(childcateg.categories_name.toString()));
    }
    return _tabs;
  }
  //
  Tab getTab(String tabtitle) {
    return Tab(
//      text: tabtitle,
      child: Text(
        tabtitle,
        style: TextStyle(fontSize: 16,color: Colors.black),
      ),
    );
  }

  TabController getTabController() {
    return TabController(length: _tabs.length, vsync: this);
  }

  Future<bool> _onWillPop() async {
    Navigator.pop(context);
    return Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>shoppingpage()));
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() => _onWillPop(),
      child: FutureBuilder(
        future: childcategorieslist,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int catlen = childcategoriesservices.length;
            _tabs = getTabs(catlen, snapshot);
            _tabController = getTabController();
            return catlen == 0
                ?
                //IF THERE ARE NO SUBCATEGORY
                Scaffold(

                    appBar: AppBar(
                      title: Text('Product Listing',style: TextStyleMediumBlack,),
                      iconTheme: IconThemeData(color: Colors.black),
                     backgroundColor: Colors.white,
                    ),
                    body: Center(
                      child: Text(
                        "No Sub Category in this Category",
                        style: TextStyleMediumBlack,
                      ),
                    ),
                  )
                //IF THERE ARE SUBCATEGORY
                : Scaffold(
//                    bottomNavigationBar: footerbar(points: footerpoints,saveprice: footersave,showfooter: footervis,),
                    appBar: AppBar(
                      iconTheme: IconThemeData(color: Colors.black),
                      backgroundColor: Colors.white,
                      title: Text(apptitle,style: TextStyle(color: Colors.black),),
                      bottom: TabBar(
                        isScrollable: true,
                        indicatorWeight: 5,
                        indicatorColor: mainaccent,
                        tabs: _tabs,
                        controller: _tabController,
                      ),
                    ),
                    body: TabBarView(
                      controller: _tabController,
                      children: getWidgets(snapshot),
                    ),
                  );
          }
          //IF it returns nothing
          return Scaffold(
            drawer: navdrawer(),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
            ),
            body: Center(
              child: SpinKitFadingCircle(
                color: mainaccent,
                size: 50.0,
                controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
              ),),
          );
        },
      ),
    );
  }
}
