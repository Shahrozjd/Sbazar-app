import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:html/parser.dart';
import 'package:sbazarapp/components/constants.dart';
import 'package:sbazarapp/components/productcard.dart';
import 'package:sbazarapp/models/searchitem_model.dart';
import 'package:sbazarapp/screens/Navdrawer.dart';
import 'package:sbazarapp/services/searchitem_services.dart';

class serachpage extends StatefulWidget {
  bool isSearching;


  serachpage({this.isSearching});

  @override
  _serachpageState createState() => _serachpageState(isSearching);
}

class _serachpageState extends State<serachpage> with TickerProviderStateMixin{
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";
  Box<bool> productbox = Hive.box('added_product');
  Box<int> productbox_quant = Hive.box('added_product_quant');
  Box<int> cartcountbox = Hive.box('cart_count');
  int cartcountkey = 102;
  int cartcount;


  _serachpageState(this._isSearching);

  Box sessionBox = Hive.box('logincheck');
  int usersessionkey = 100;
  int useremailkey = 101;
  String useremail;
  bool usersession;
  String email;
  String exname;

  Box<bool> favproductbox = Hive.box('favproducts');
  bool isfav;


  Future<List<searchitem_model>> searchitemfuture;

  @override
  void initState() {
    cartcount = cartcountbox.get(cartcountkey,defaultValue: 0);
    super.initState();
  }

  AppBar customAppbar()
  {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      title: _isSearching ? _buildSearchField() :
      InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Image.asset(
          'images/horizontal_logo.png',
          height: 100,
          width: 100,
        ),
      ),
      actions: _buildActions(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: Container(
        child: FutureBuilder(
          future: searchitemfuture,
          builder: (context,snapshot)
          {
            if(snapshot.hasData)
              {

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.60,
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,index){
                    searchitem_model serachitem = snapshot.data[index];
                    bool enableadder = productbox.get(serachitem.products_id,defaultValue: false);
                    int productquant = productbox_quant.get(serachitem.products_id,defaultValue: 0);
                    String productdesc_html = serachitem.products_description;
                    isfav = favproductbox.get(serachitem.products_id,defaultValue: false);
                    final document = parse(productdesc_html);
                    final String parsed_prod_desc = parse(document.body.text).documentElement.text;

                    print(serachitem.products_points);
                    print(serachitem.products_price_market);
                    print(serachitem.products_price);
                    print(exname);

                    return productcard(
                      title: serachitem.products_name.toString(),
                      weight: serachitem.products_weight +
                          " " +
                          serachitem.products_weight_unit,
                      price: serachitem.products_price,
                      imagepath:
                      'http://www.sbazar.gmbh/public/images/media/2020/12/' +
                          serachitem.image_of_product.toString(),
                      product_id: serachitem.products_id,
                      marketprice: serachitem.products_price_market.toString(),
                      productpoints: serachitem.products_points.toString(),
                      productstatus: serachitem.products_status,
                      enabeladder: enableadder,
                      productquantitiy: enableadder?productquant:1,
                      productdesc: parsed_prod_desc,
                      productsku: serachitem.products_sku,
                      isfav: isfav,
                    );
                  },
                );

              }
            return Center(
            child: Text('Search item will be listed here'),
//            child: SpinKitFadingCircle(
//            color: mainaccent,
//          size: 50.0,
//          controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
//          ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      onSubmitted: (String value)
      {
        setState(() {
          exname = value;
          searchitem_model searchitem = searchitem_model(name: value);
          searchitemfuture = searchitem_services().getAllCart(searchitem);
        });

      },
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Colors.white, fontSize: 20),
        hintText: "Search Data...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white70, fontSize: 20),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }
}

class searchitem extends StatefulWidget {
  String imagepath;
  String title;
  String price;
  String weight;

  searchitem({this.imagepath, this.title, this.price,this.weight});

  @override
  _searchitemState createState() => _searchitemState();
}

class _searchitemState extends State<searchitem> {


  @override
  void initState() {
    // TODO: implement initState
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
            flex: 4,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
