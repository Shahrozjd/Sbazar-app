import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:html/parser.dart';
import 'package:sbazarapp/components/carticon.dart';
import 'package:sbazarapp/components/constants.dart';
import 'package:sbazarapp/components/productcard.dart';
import 'package:sbazarapp/models/favproduct_model.dart';
import 'package:sbazarapp/screens/Navdrawer.dart';
import 'package:sbazarapp/screens/mainpage.dart';
import 'package:sbazarapp/services/favproduct_services.dart';

class favitemspage extends StatefulWidget {
  @override
  _favitemspageState createState() => _favitemspageState();
}

class _favitemspageState extends State<favitemspage> with TickerProviderStateMixin{
  Future<List<favproduct_model>> favproductlist_future;

  Box<bool> productbox = Hive.box('added_product');
  Box<int> productbox_quant = Hive.box('added_product_quant');

//  Box<int> cartcountbox = Hive.box('cart_count');
//  int cartcountkey = 102;
//  int cartcount;



  Box sessionBox = Hive.box('logincheck');
  int usersessionkey = 100;
  int useremailkey = 101;
  String useremail;
  bool usersession;
  String email;

  Box<bool> favproductbox = Hive.box('favproducts');
  bool isfav;

  @override
  void initState() {

    //get cart count
//    cartcount = cartcountbox.get(cartcountkey,defaultValue: 0);

    //getfav
    email = sessionBox.get(useremailkey, defaultValue: null);
    if (email != null) {
      print(email);
      favproduct_model favprodmodel = favproduct_model(email: email);
      favproductlist_future =
          favproduct_services().getAllFavProducts(favprodmodel);
    }

    super.initState();
  }

  Future<bool> _onWillPop() async {
    Navigator.pop(context);
    return Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>mainpage()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
//        actions: [
//          Padding(
//            padding: const EdgeInsets.only(right:8.0),
//            child: carticon(productcount: cartcount,),
//          )
//        ],
          title: Text('Favourite Products'),
        ),
        drawer: navdrawer(),
        body: email != null
            ? Container(
                padding: EdgeInsets.all(15),
                child: FutureBuilder(
                  future: favproductlist_future,
                  builder: (context,snapshot)
                  {
                    if(snapshot.hasData)
                      {
                          return GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.55,
                            ),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context,index){
                              favproduct_model favproduct = snapshot.data[index];
                              bool enableadder = productbox.get(favproduct.products_id,defaultValue: false);
                              int productquant = productbox_quant.get(favproduct.products_id,defaultValue: 0);
                              String productdesc_html = favproduct.products_description;
                              isfav = favproductbox.get(favproduct.products_id,defaultValue: false);
                              final document = parse(productdesc_html);
                              final String parsed_prod_desc = parse(document.body.text).documentElement.text;
                              return productcard(
                                title: favproduct.products_name.toString(),
                                weight: favproduct.products_weight +
                                    " " +
                                    favproduct.products_weight_unit,
                                price: favproduct.products_price,
                                imagepath:
                                'http://www.sbazar.gmbh/public/images/media/2020/12/' +
                                    favproduct.image_of_product.toString(),
                                product_id: favproduct.products_id,
                                marketprice: favproduct.products_price_market.toString(),
                                productpoints: favproduct.products_points.toString(),
                                productstatus: favproduct.products_status,
                                enabeladder: enableadder,
                                productquantitiy: enableadder?productquant:1,
                                productdesc: parsed_prod_desc,
                                productsku: favproduct.products_sku,
                                isfav: isfav,
                              );
                            },
                          );
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
              )
            : Center(
                child: Text("Please Sign In to see your Fav Products"),
              ),
      ),
    );
  }
}
