import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:sbazarapp/components/MainAppbBar.dart';
import 'package:sbazarapp/components/RectButton.dart';
import 'package:sbazarapp/components/RectButtonAlt.dart';
import 'package:sbazarapp/components/carticon.dart';
import 'package:sbazarapp/components/constants.dart';
import 'package:sbazarapp/components/footer.dart';
import 'package:sbazarapp/models/cart_model.dart';
import 'package:sbazarapp/models/favproduct_model.dart';
import 'package:sbazarapp/screens/BottomNav.dart';
import 'package:sbazarapp/screens/ProductListing.dart';
import 'package:sbazarapp/services/cart_services.dart';
import 'package:sbazarapp/services/favproduct_services.dart';
import 'package:toast/toast.dart';

//PRODUCT CARD
class productcard extends StatefulWidget {
  String title;
  String weight;
  String price;
  String imagepath;
  int product_id;
  bool enabeladder;
  int productquantitiy;
  String marketprice;
  String productpoints;
  String productdesc;
  String productsku;
  int productstatus;
  bool isfav;

  productcard({
    this.title,
    this.weight,
    this.price,
    this.imagepath,
    this.product_id,
    this.enabeladder,
    this.productquantitiy,
    this.marketprice,
    this.productpoints,
    this.productstatus,
    this.productdesc,
    this.productsku,
    this.isfav
  });

  @override
  _productcardState createState() => _productcardState(
      title,
      weight,
      price,
      imagepath,
      product_id,
      enabeladder,
      productquantitiy,
      marketprice,
      productpoints,
      productstatus,
      productdesc,
      productsku,
      isfav,
  );
}

class _productcardState extends State<productcard> {
  String title;
  String weight;
  String price;
  String imagepath;
  int product_id;
  bool enableadder = false;
  String marketprice;
  String productpoints;
  String productdesc;
  String productsku;
  int productstatus;
  bool isfav;

  int productquantity = 1;

  _productcardState(
    this.title,
    this.weight,
    this.price,
    this.imagepath,
    this.product_id,
    this.enableadder,
    this.productquantity,
    this.marketprice,
    this.productpoints,
    this.productstatus,
    this.productdesc,
    this.productsku,
    this.isfav
  );


  String email;
  Box sessionBox = Hive.box('logincheck');
  int usersessionkey = 100;
  int useremailkey = 101;
  String useremail;
  bool usersession;
  double totalprice = 0.0;

  Box<int> cartcountbox = Hive.box('cart_count');
  int cartcountkey = 102;
  int cartcount;

  Box<bool> productbox = Hive.box('added_product');
  Box<int> productbox_quant = Hive.box('added_product_quant');
  Box<bool> favproductbox = Hive.box('favproducts');
  int isfavkey = 103;
  

  Box pointbox = Hive.box('pointdata');
  int pointboxkeypoint = 105;


  //ADD TO CART AND QUANTITY
  addtocart(cart_model addtocartmodel) async {
    await cart_services().addtocart(addtocartmodel).then((value) {
      final body = json.decode(value);
      Toast.show(body['message'], context, gravity: Toast.BOTTOM, duration: 2);
    });
  }
  removeformcart(cart_model addtocartmodel) async {
    await cart_services().removefromcart(addtocartmodel).then((value) {
      final body = json.decode(value);
      Toast.show(body['message'], context, gravity: Toast.BOTTOM, duration: 2);
    });
  }
  addquantcart(cart_model addqunatcartmodel) async {
    await cart_services().addquantcart(addqunatcartmodel).then((value) {
      final body = json.decode(value);
      Toast.show(body['message'], context, gravity: Toast.BOTTOM, duration: 2);
    });
  }


  //ADDING REMOVING FAV PRODUCTS
  addfavproduct(favproduct_model favprodmodel) async {
    await favproduct_services().addFavProducts(favprodmodel).then((value) {
      final body = json.decode(value);
      Toast.show(body['message'], context, gravity: Toast.BOTTOM, duration: 2);
    });
  }

  delfavproduct(favproduct_model favprodmodel) async{
    await favproduct_services().delFavProducts(favprodmodel).then((value){
      final body = json.decode(value);
      Toast.show(body['message'], context, gravity: Toast.BOTTOM, duration: 2);
    });
  }

  @override
  void initState() {

    email = sessionBox.get(useremailkey, defaultValue: null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: !enableadder
            ? () {
                setState(() {
                  //check user login
                  if (email != null) {
                    enableadder = true;
                    //adding item to cart
                    cart_model addtocartmodel = cart_model(
                        email: email, products_id: product_id.toString());
                    addtocart(addtocartmodel);


//                    //TODO wait what
//                    mycartstate.setState(() {
//                      mycartstate.productcount += 1;
//                      cartcountbox.put(cartcountkey, mycartstate.productcount);
//                    });
                    mypresistentbottombarstate.setState(() {
                      mypresistentbottombarstate.productcount += 1;
                      cartcountbox.put(cartcountkey, mypresistentbottombarstate.productcount);

                    });
                    productbox.put(product_id, true);
                    productbox_quant.put(product_id, productquantity);


                    myappbarstate.setState(() {
                      MainAppbarState.points += int.parse(productpoints);
                      pointbox.put(pointboxkeypoint, MainAppbarState.points);
                    });

//                    print("market: "+marketprice.toString());
//                    print("save: "+footerbarstate.saveprice.toString());
//                    print(price);
//                    footerbarstate.setState(() {
//                      footerbarstate.showfooter = true;
//                      footerbarstate.points += int.parse(productpoints);
//                      if(marketprice=='0')
//                        {
//                          footerbarstate.saveprice += 0.0;
//                          footerbox.put(footerboxkeysave,footerbarstate.saveprice);
//                        }
//                      else
//                        {
//                          footerbarstate.saveprice +=double.parse(marketprice) - double.parse(price);
//                          footerbox.put(footerboxkeysave,footerbarstate.saveprice);
//                        }
//                      footerbox.put(footerboxkeypoint,footerbarstate.points);
//                      footerbox.put(footerboxkeyvisibility,true);
//                    });
                  } else {
                    Toast.show(
                        "Please sign in to add products to cart", context,
                        gravity: Toast.BOTTOM, duration: 2);
                  }
                });
              }
            : () {},
        child: enableadder ? enabledproductcontainer() : productcontainer());
  }

  Container productcontainer() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(imagepath),
              fit: BoxFit.cover,
            )),
            child: Container(
              padding: EdgeInsets.all(5),
              color: Colors.black.withOpacity(0.3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          if (!isfav) {
                            isfav = true;
                            favproduct_model favmodel = favproduct_model(email: email,products_id: product_id.toString());
                            addfavproduct(favmodel);
                            favproductbox.put(product_id, true);
                            print(isfav);
                          } else {
                            isfav = false;
                            favproduct_model favmodel = favproduct_model(email: email,products_id: product_id.toString());
                            delfavproduct(favmodel);
                            favproductbox.put(product_id, false);
                            print(isfav);
                          }
                        });
                      },
                      child: isfav
                          ? Icon(
                              FontAwesomeIcons.solidHeart,
                              color: Colors.white,
                            )
                          : Icon(
                              FontAwesomeIcons.heart,
                              color: Colors.white,
                            )),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        // SHOWING ALL DESCRIPTION in  bottom modal sheet
                        bottomsheetmodal();
                      },
                      splashColor: Colors.black.withOpacity(0.5),
                      child: Icon(
                        FontAwesomeIcons.infoCircle,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: TextStyleFormBlackBold,
                  ),
                  Row(
                    children: [
                      Text(weight),
                      Text(' | '),
                      Text(productpoints + " points"),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Market Price ',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        marketprice + " €",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w800, color: mainaccent),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(price + " €", style: TextStyleFormAccentBold),
                      Icon(FontAwesomeIcons.shareAlt)
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container enabledproductcontainer() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Colors.black.withOpacity(0.4)),
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(imagepath),
              fit: BoxFit.cover,
            )),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.black.withOpacity(0.2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              if (!isfav) {
                                isfav = true;
                                favproduct_model favmodel = favproduct_model(email: email,products_id: product_id.toString());
                                addfavproduct(favmodel);
                                favproductbox.put(product_id, true);
                                print(isfav);
                              } else {
                                isfav = false;
                                favproduct_model favmodel = favproduct_model(email: email,products_id: product_id.toString());
                                delfavproduct(favmodel);
                                favproductbox.put(product_id, false);
                                print(isfav);
                              }
                            });
                          },
                          child: isfav
                              ? Icon(
                                  FontAwesomeIcons.solidHeart,
                                  color: Colors.white,
                                )
                              : Icon(
                                  FontAwesomeIcons.heart,
                                  color: Colors.white,
                                )),
                      Icon(
                        FontAwesomeIcons.infoCircle,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RectButtonAlt(
                        textval: '-',
                        width: 50,
                        height: 40,
                        onpress: () {
                          setState(() {
                            if (productquantity == 1) {
                              enableadder = false;
                              cart_model removecartmodel = cart_model(
                                  email: email,
                                  products_id: product_id.toString());
                              removeformcart(removecartmodel);
                              //TODO wait what
                              mypresistentbottombarstate.setState(() {
                                mypresistentbottombarstate.productcount -= 1;
                                cartcountbox.put(cartcountkey, mypresistentbottombarstate.productcount);
                                productbox.put(product_id, false);
                                productbox_quant.put(product_id, 0);

                              });

                              if(mypresistentbottombarstate.productcount == 0)
                                {
                                    pointbox.put(pointboxkeypoint, 0);
                                }

//                              if(mycartstate.productcount==0)
//                                {
//                                  footerbox.put(footerboxkeypoint,0.0);
//                                  footerbox.put(footerboxkeysave,0.0);
//                                  footerbox.put(footerboxkeyvisibility,false);
//                                  print("KABOOOM");
//                                  footerbarstate.setState(() {
//                                    footerbarstate.showfooter = false;
//                                  });
//                                }
                              productquantity = 2;
                            }
                            productquantity -= 1;
                            productbox_quant.put(product_id, productquantity);
                            cart_model addqunatcartmodel = cart_model(
                                email: email,
                                products_id: product_id.toString(),
                                products_quantity: productquantity.toString());
                            addquantcart(addqunatcartmodel);

                            myappbarstate.setState(() {
                              MainAppbarState.points -= int.parse(productpoints);
                              pointbox.put(pointboxkeypoint, MainAppbarState.points);
                            });
                          });
                        },
                      ),
                      Text(
                        productquantity.toString(),
                        style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      RectButton(
                        textval: '+',
                        width: 50,
                        height: 40,
                        onpress: () {
                          setState(() {

                            myappbarstate.setState(() {
                              MainAppbarState.points += int.parse(productpoints);
                              pointbox.put(pointboxkeypoint, MainAppbarState.points);
                            });
//                            print("market: "+marketprice.toString());
//                            print(price);
//                            footerbarstate.setState(() {
//                              footerbarstate.points += int.parse(productpoints);
//                              if(marketprice=='0')
//                              {
//                                footerbarstate.saveprice += 0.0;
//                                footerbox.put(footerboxkeysave,footerbarstate.saveprice);
//                              }
//                              else
//                              {
//                                footerbarstate.saveprice +=double.parse(marketprice) - double.parse(price);
//                                footerbox.put(footerboxkeysave,footerbarstate.saveprice);
//                              }
//                              footerbox.put(footerboxkeypoint,footerbarstate.points);
//                            });

                            print(productquantity);
                            productquantity += 1;
                            productbox_quant.put(product_id, productquantity);
                            print(productquantity);
                            cart_model addqunatcartmodel = cart_model(
                                email: email,
                                products_id: product_id.toString(),
                                products_quantity: productquantity.toString());
                            addquantcart(addqunatcartmodel);
                          });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: TextStyleFormBlackBold,
                  ),
                  Row(
                    children: [
                      Text(weight),
                      Text(' | '),
                      Text(productpoints + " points"),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Market Price ',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        marketprice + " €",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w800,color: mainaccent),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(price + " €", style: TextStyleFormAccentBold),
                      Icon(FontAwesomeIcons.shareAlt)
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> bottomsheetmodal()
  {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
                height:
                MediaQuery.of(context).size.height * 0.75,
                decoration: BoxDecoration(
                    color: Color(0xFFFAFAFA),
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(40.0),
                        topRight:
                        const Radius.circular(40.0))),
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      //header
                      Container(
                        height: 200,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: ClipRRect(
                                borderRadius:
                                BorderRadius.all(
                                    Radius.circular(15)),
                                child: Image.network(imagepath),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceAround,
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .stretch,
                                  children: [
                                    Text(
                                      title,
                                      style:
                                      TextStyleFormBlackBold,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                            weight),
                                        Text(" | "),
                                        Text(
                                            productpoints+" points"),
                                      ],
                                    ),
                                    Text(marketprice+' €'),
                                    Text(price+' €',
                                        style:
                                        TextStyleFormBlackBold),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      //body
                      Expanded(
                        child: Container(
                          color: Colors.grey[100],
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'About this product',
                                style: TextStyleFormBlackBold,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                  productdesc,
                                  style: TextStyleFormBlack),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'SKU',
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight.bold),
                                  ),
                                  Text(' : '),
                                  Text(productsku),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Availability',
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight.bold),
                                  ),
                                  Text(' : '),
                                  Text('----'),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          );
        });
  }
}
