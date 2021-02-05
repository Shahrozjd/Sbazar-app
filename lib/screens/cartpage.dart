import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:html/parser.dart';
import 'package:sbazarapp/components/DarkTextField.dart';
import 'package:sbazarapp/components/RectButtonAlt.dart';
import 'package:sbazarapp/components/constants.dart';
import 'package:sbazarapp/models/getcart_model.dart';
import 'package:sbazarapp/screens/checkout.dart';
import 'package:sbazarapp/services/getcart_services.dart';

class cartpage extends StatefulWidget {
  @override
  _cartpageState createState() => _cartpageState();
}

class _cartpageState extends State<cartpage> with TickerProviderStateMixin {
  String email;
  Box sessionBox = Hive.box('logincheck');
  int usersessionkey = 100;
  int useremailkey = 101;
  String useremail;
  bool usersession;
  double totalprice = 0.0;

  Future<List<getcart_model>> getcartmodel_future;

  getcartproducts() {
    email = sessionBox.get(useremailkey, defaultValue: null);
    if (email != null) {
      getcart_model getcartmodel = getcart_model(email: email);
      getcartmodel_future = getcart_services().getAllCart(getcartmodel);
    }
  }

  @override
  void initState() {
    getcartproducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return email != null
        ? Scaffold(

            //Cehckout flutter
            floatingActionButton: Material(
              elevation: 6.0,
              shadowColor: mainaccent,
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: mainaccent,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>checkoutpage()));
                  },
                  splashColor: Colors.white.withOpacity(0.5),
                  child: SizedBox(
                    width: 150,
                    height: 60,
                    child: Center(
                      child: Text(
                        'CHECKOUT',
                        style: TextStyleForm,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            appBar: AppBar(
              title: Text(
                'My Cart',
                style: TextStyle(color: Colors.black),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
            ),
            body: FutureBuilder(
              future: getcartmodel_future,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  int length = getcart_services.length;
                  return SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          //first child
                          Container(
                            color: containerbackground,
                            padding: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //item count
                                Row(
                                  children: [
                                    Text(
                                      'TOTAL',
                                      style: TextStyleFormAccentBold,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      length.toString(),
                                      style: TextStyleFormAccent,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      'items',
                                      style: TextStyleFormAccent,
                                    ),
                                  ],
                                ),
                                //Clear Cart
                                Text(
                                  'CLEAR CART',
                                  style: TextStyle(
                                      color: Colors.deepOrange, fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          //ITEMS
                          Container(
                            child: ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                getcart_model getcartmodel =
                                    snapshot.data[index];
                                return cartitem(
                                  title: getcartmodel.products_name,
                                  price: getcartmodel.products_price + " €",
                                  weight: getcartmodel.products_weight +
                                      " " +
                                      getcartmodel.products_weight_unit,
                                  imagepath:
                                      'http://www.sbazar.gmbh/public/images/media/2020/12/' +
                                          getcartmodel.image_of_product
                                              .toString(),
                                  quantity: getcartmodel.cart_quantity,
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          //COUPON CODE
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: DarkTextField(
                                    hasfocus: true,
                                    obscuretext: false,
                                    hintext: 'Coupon Code',
                                    labeltext: null,
                                    inputtype: TextInputType.text,
                                    onChanged: (String getCoupon) {},
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: 50,
                                    color: containerbackground,
                                    child: FlatButton(
                                      textColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        'Apply',
                                        style: TextStyleFormAccent,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //TOTAL PRICE
                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(bottom: 80),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              color: containerbackground,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Products',
                                        style: TextStyleFormBlack,
                                      ),
                                      Text(
                                        'x8',
                                        style: TextStyleFormBlack,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total:',
                                        style: TextStyleMediumBlack,
                                      ),
                                      Text(
                                        totalprice.toString() + " USD",
                                        style: TextStyleMediumBlack,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
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
            ))
        : Scaffold(
            appBar: AppBar(iconTheme: IconThemeData(color: Colors.black),title: Text('CART',style: TextStyle(color: Colors.black)),backgroundColor: Colors.white,),
            body: Center(
              child: Text('Kindly Login first'),
            ));
  }
}

class cartitem extends StatefulWidget {
  String imagepath;
  String title;
  String price;
  int quantity;
  String weight;

  cartitem(
      {this.imagepath, this.title, this.price, this.quantity, this.weight});

  @override
  _cartitemState createState() => _cartitemState();
}

class _cartitemState extends State<cartitem> {
  int _itemCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    _itemCount = widget.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 250,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Icon(
                FontAwesomeIcons.minusCircle,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.imagepath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.title,
                    style: TextStyleMediumBlack,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.price,
                    style: TextStyleFormBlack,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.weight,
                    style: TextStyleFormBlack,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 60,
                        child: FlatButton(
                          child: new Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (_itemCount < 1) {
                                _itemCount = 0;
                              } else {
                                _itemCount--;
                              }
                            });
                          },
                          textColor: Colors.white,
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      new Text(
                        _itemCount.toString(),
                        style: TextStyleMediumBlackBold,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 60,
                        child: FlatButton(
                          child: new Icon(Icons.add),
                          onPressed: () => setState(() => _itemCount++),
                          textColor: Colors.white,
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
