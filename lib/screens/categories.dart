import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:html/parser.dart';
import 'package:sbazarapp/components/constants.dart';
import 'package:sbazarapp/components/customloading.dart';
import 'package:sbazarapp/components/productcard.dart';
import 'package:sbazarapp/models/categoriesmodel.dart';
import 'package:sbazarapp/models/childcategoriesmodel.dart';
import 'package:sbazarapp/models/productmodel.dart';
import 'package:sbazarapp/services/categoriesservices.dart';
import 'package:sbazarapp/services/childcategoriesservices.dart';
import 'package:sbazarapp/services/productservices.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class categoriespage extends StatefulWidget {
  @override
  _categoriespageState createState() => _categoriespageState();
}

class _categoriespageState extends State<categoriespage> with TickerProviderStateMixin{
  int amount = 1;
  int _startingTabCount = 0;
  List<Tab> _tabs = List<Tab>();
  List<Widget> _generalWidgets = List<Widget>();
  TabController _tabController;

  Box<bool> productbox = Hive.box('added_product');
  Box<int> productbox_quant = Hive.box('added_product_quant');
  Box<bool> favproductbox = Hive.box('favproducts');
  bool isfav;
  int isfavkey = 103;

  String parentid;


  Future<List<childcategoriesmodel>> childcategorieslist;
  Future<List<productmodel>> productlist;

  @override
  void initState() {
      super.initState();
  }

  //SHOW ALL WIDGETS and get snapshot for category id
  List<Widget> getWidgets(AsyncSnapshot snapshot) {
    _generalWidgets.clear();
    for (int i = 0; i < _tabs.length; i++) {
      childcategoriesmodel childcateg = snapshot.data[i];
      productlist = productservices().getProduct(childcateg.categories_id.toString());
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
      child: Text(
        tabtitle,
      ),
    );
  }

  TabController getTabController() {
    return TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xFFFAFAFA),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Categories',
            style: TextStyle(color: Colors.black),
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: 120,
            child: FutureBuilder<List<categoriesmodel>>(
              future: categoriesservices().getCategories(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      categoriesmodel categ = snapshot.data[index];
                      return headerListIcon(
                        name: categ.categories_name,
                        imagepath:
                            'http://www.sbazar.gmbh/public/images/media/2021/01/' +
                                categ.icon_of_category.toString(),
                        ontap: (){
                            setState(() {
                              parentid = categ.categories_id.toString();
                              childcategorieslist = childcategoriesservices().getCategories(parentid);
                              print(parentid);
                            });
                        },
                      );
                    },
                  );
                }
                return customloading();
              },
            ),
          ),

          Expanded(
            child: FutureBuilder(
              future: childcategorieslist,
              builder: (context,snapshot){
                if (snapshot.hasData) {
                  int catlen = childcategoriesservices.length;
                  _tabs = getTabs(catlen, snapshot);
                  _tabController = getTabController();
                  return catlen == 0
                      ?
                  //IF THERE ARE NO SUBCATEGORY
                   Center(
                      child: Text(
                        "No Sub Category in this Category",
                        style: TextStyleMediumBlack,
                      ),
                    )

                  //IF THERE ARE SUBCATEGORY
                      : DefaultTabController(
                      length: catlen,
                      child: Column(
                        children: [
                          TabBar(
                            isScrollable: true,
                            unselectedLabelColor: Colors.black,
                            indicatorSize:TabBarIndicatorSize.tab,
                            indicator: new BubbleTabIndicator(
                              indicatorHeight: 40.0,
                              padding: EdgeInsets.all(5),
                              indicatorColor: mainaccent,
                              tabBarIndicatorSize: TabBarIndicatorSize.tab,
                            ),
                            tabs: _tabs,
                            controller: _tabController,
                          ),
                          Expanded(
                            child: Container(
                              child : TabBarView(
                                controller: _tabController,
                                children:
                                getWidgets(snapshot),

                              ),
                            ),
                          )
                        ],
                      ),
                      );
                }
                //IF it returns nothing
                return Center(
                    child: SpinKitFadingCircle(
                      color: mainaccent,
                      size: 50.0,
                      controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
                    ),);
              },
            ),
          )
        ],
      ),
    );
  }
}

class headerListIcon extends StatefulWidget {
  String name;
  String imagepath;
  Function ontap;

  headerListIcon({this.name, this.imagepath,this.ontap});

  @override
  _headerListIconState createState() => _headerListIconState();
}



class _headerListIconState extends State<headerListIcon> {




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Column(
        children: [
          Container(
            height: 70.0,
            width: 70.0,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 5.0, right: 5.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100.0),
              border: Border.all(
                  width: 2.0,
                  style: BorderStyle.solid,
                  color: Colors.grey),
            ),
            child: Image.network(widget.imagepath),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
              width: 80,
              child: Text(
                widget.name,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ))
        ],
      ),
    );
  }
}
