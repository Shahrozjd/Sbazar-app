import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:sbazarapp/components/constants.dart';
import 'package:sbazarapp/models/pagedetailModel.dart';
import 'package:sbazarapp/screens/Navdrawer.dart';
import 'package:sbazarapp/services/pagedetailServices.dart';

class pagedetail extends StatefulWidget {
  String id;


  pagedetail({this.id});

  @override
  _pagedetailState createState() => _pagedetailState();
}

class _pagedetailState extends State<pagedetail> {

  Future<pagedetailModel> pagedetail_future;

  @override
  void initState() {
    print(widget.id);
    pagedetailModel pagedetailmodel = pagedetailModel(page_id:widget.id );
    pagedetail_future = pagedetailServices().getAllPages(pagedetailmodel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: pagedetail_future,
      builder: (context,snapshot){
        if(snapshot.hasData)
          {
            pagedetailModel pagemodel = snapshot.data;
            final document = parse(pagemodel.description.toString());
            final String parsed_prod_desc = parse(document.body.text).documentElement.text;
            return Scaffold(
              drawer: navdrawer(),
              appBar: AppBar(title: Text(pagemodel.name.toString()),),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(parsed_prod_desc,style: TextStyleFormBlack,),
                ),
              ),
            );
          }
        return Scaffold(
          appBar: AppBar(title:Text("More")),
          body: Container(),
        );
      }
    );
  }
}
