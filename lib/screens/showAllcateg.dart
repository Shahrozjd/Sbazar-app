import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:html/parser.dart';
import 'package:sbazarapp/components/constants.dart';
import 'package:sbazarapp/components/productcard.dart';
import 'package:sbazarapp/models/productmodel.dart';

class showAllcategPage extends StatefulWidget {

  String bartitle;
  Future Categfuture;


  showAllcategPage({this.bartitle, this.Categfuture});

  @override
  _showAllcategPageState createState() => _showAllcategPageState();
}

class _showAllcategPageState extends State<showAllcategPage> with TickerProviderStateMixin{
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(widget.bartitle,style: TextStyle(color: Colors.black)),),
      body: Container(
        padding: EdgeInsets.all(15),
        child: FutureBuilder(
          future: widget.Categfuture,
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
                  productmodel excproduct = snapshot.data[index];
                  bool enableadder = productbox.get(excproduct.products_id,defaultValue: false);
                  int productquant = productbox_quant.get(excproduct.products_id,defaultValue: 0);
                  String productdesc_html = excproduct.products_description;
                  isfav = favproductbox.get(excproduct.products_id,defaultValue: false);
                  final document = parse(productdesc_html);
                  final String parsed_prod_desc = parse(document.body.text).documentElement.text;
                  return productcard(
                    title: excproduct.products_name.toString(),
                    weight: excproduct.products_weight +
                        " " +
                        excproduct.products_weight_unit,
                    price: excproduct.products_price,
                    imagepath:
                    'http://www.sbazar.gmbh/public/images/media/2020/12/' +
                        excproduct.image_of_product.toString(),
                    product_id: excproduct.products_id,
                    marketprice: excproduct.products_price_market.toString(),
                    productpoints: excproduct.products_points.toString(),
                    productstatus: excproduct.products_status,
                    enabeladder: enableadder,
                    productquantitiy: enableadder?productquant:1,
                    productdesc: parsed_prod_desc,
                    productsku: excproduct.products_sku,
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
      ),
    );
  }
}
