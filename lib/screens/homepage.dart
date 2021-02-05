import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:html/parser.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sbazarapp/components/MainAppbBar.dart';
import 'package:sbazarapp/components/carticon.dart';
import 'package:sbazarapp/components/constants.dart';
import 'package:sbazarapp/components/footer.dart';
import 'package:sbazarapp/components/productcard.dart';
import 'package:sbazarapp/models/productmodel.dart';
import 'package:sbazarapp/models/sliderimagesModel.dart';
import 'package:sbazarapp/screens/Navdrawer.dart';
import 'package:sbazarapp/screens/mainpage.dart';
import 'package:sbazarapp/screens/serachpage.dart';
import 'package:sbazarapp/screens/showAllcateg.dart';
import 'package:sbazarapp/services/exclusiveproductServices.dart';
import 'package:sbazarapp/services/featuredproductsServices.dart';
import 'package:sbazarapp/services/flashproductServices.dart';
import 'package:sbazarapp/services/newproductServices.dart';
import 'package:sbazarapp/services/redeemproductServices.dart';
import 'package:sbazarapp/services/sliderimageServices.dart';
import 'package:sbazarapp/services/specialproductServices.dart';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> with TickerProviderStateMixin {
  Future<List<sliderimageModel>> slidermodel_future;

//  Box<int> cartcountbox = Hive.box('cart_count');
//  int cartcountkey = 102;
//  int cartcount;

  Box<bool> productbox = Hive.box('added_product');
  Box<int> productbox_quant = Hive.box('added_product_quant');
  Box<bool> favproductbox = Hive.box('favproducts');
  bool isfav;
  int isfavkey = 103;

  Box pointbox = Hive.box('pointdata');
  int pointboxkeypoint = 105;
  int point;

//  bool footervis;
//  int footerpoints;
//  double footersave;
//  Box footerbox = Hive.box('footerdata');
//  int footerboxkeypoint = 105;
//  int footerboxkeysave = 106;
//  int footerboxkeyvisibility = 107;

  @override
  void initState() {
//    cartcount = cartcountbox.get(cartcountkey, defaultValue: 0);
    slidermodel_future = sliderimageServices().getAllSliders();

    //getting points data
    point = pointbox.get(pointboxkeypoint,defaultValue: 0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CarouselSlider(
      options: CarouselOptions(height: 400.0),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(color: Colors.amber),
                child: Text(
                  'text $i',
                  style: TextStyle(fontSize: 16.0),
                ));
          },
        );
      }).toList(),
    );





    return Scaffold(
      appBar: MainAppbar(
        appBar: AppBar(),
        point: point,
      ),
      drawer: navdrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 10),
          child: Column(
            children: [
              FutureBuilder(
                future: slidermodel_future,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CarouselSlider.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        sliderimageModel slidermodel = snapshot.data[index];
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "http://www.sbazar.gmbh/public/images/media/2020/05/" +
                                          slidermodel.image_of_slider
                                              .toString()),
                                  fit: BoxFit.cover)),
                        );
                      },
                      options: CarouselOptions(
                        height: 200.0,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    );
                  }
                  return Container();
                },
              ),

              //BODY
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              //Featured Products
              prouctslists(
                title: 'Featured Products',
                listfuture: featuredproductServices().getfeaturedProducts(),
              ),
              //Exclusive Products
              prouctslists(
                title: 'Exclusive Products',
                listfuture: exclusiveproductServices().getExclusiveProducts(),
              ),
              //New Products
              prouctslists(
                title: 'New Products',
                listfuture: newproductServices().getNewProducts(),
              ),
              //Flash Products
              prouctslists(
                title: 'Flash Deals ⚡',
                listfuture: flashproductServices().getflashProducts(),
              ),
              //Redeem Products
              prouctslists(
                title: 'Redeem Products',
                listfuture: redeemproductServices().getredeemProducts(),
              ),
              //special Products
              prouctslists(
                title: 'Discount Products',
                listfuture: specialproductServices().getspecialProducts(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container prouctslists({String title, Future listfuture}) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyleFormBlackBold,
                ),
                Material(
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>showAllcategPage(
                          bartitle: title,
                          Categfuture: listfuture,
                        )
                      ));
                    },
                    child: Text(
                      'View More',
                      style: TextStyleFormAccent,
                    ),
                  ),
                )
              ],
            ),
          ),
          FutureBuilder(
            future: listfuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: AspectRatio(
                    aspectRatio: 1.15,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          snapshot.data.length > 10 ? 10 : snapshot.data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        productmodel excproduct = snapshot.data[index];
                        bool enableadder = productbox
                            .get(excproduct.products_id, defaultValue: false);
                        int productquant = productbox_quant
                            .get(excproduct.products_id, defaultValue: 0);
                        String productdesc_html =
                            excproduct.products_description;
                        isfav = favproductbox.get(excproduct.products_id,
                            defaultValue: false);
                        final document = parse(productdesc_html);
                        final String parsed_prod_desc =
                            parse(document.body.text).documentElement.text;

                        return AspectRatio(
                          aspectRatio: 0.60,
                          child: productcard(
                            title: excproduct.products_name.toString(),
                            weight: excproduct.products_weight +
                                " " +
                                excproduct.products_weight_unit,
                            price: excproduct.products_price,
                            imagepath:
                                'http://www.sbazar.gmbh/public/images/media/2020/12/' +
                                    excproduct.image_of_product.toString(),
                            product_id: excproduct.products_id,
                            marketprice: excproduct.products_price_market
                                        .toString() ==
                                    "null"
                                ? "0"
                                : excproduct.products_price_market.toString(),
                            productpoints:
                                excproduct.products_points.toString(),
                            productstatus: excproduct.products_status,
                            enabeladder: enableadder,
                            productquantitiy: enableadder ? productquant : 1,
                            productdesc: parsed_prod_desc,
                            productsku: excproduct.products_sku,
                            isfav: isfav,
                          ),
                        );
                      },
                    ),
                  ),
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
          )
        ],
      ),
    );
  }
}

