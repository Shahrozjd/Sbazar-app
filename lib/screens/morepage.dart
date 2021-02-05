import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sbazarapp/components/constants.dart';
import 'package:sbazarapp/models/morepageModel.dart';
import 'package:sbazarapp/screens/Navdrawer.dart';
import 'package:sbazarapp/screens/pagedetails.dart';
import 'package:sbazarapp/services/morepageServices.dart';

class morepage extends StatefulWidget {
  @override
  _morepageState createState() => _morepageState();
}

class _morepageState extends State<morepage> with TickerProviderStateMixin {
  Future<List<morepageModel>> moremodel_future;

  @override
  void initState() {
    moremodel_future = morepageServices().getAllPages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: navdrawer(),
      appBar: AppBar(title: Text("More")),
      body: Container(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
          future: moremodel_future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context,index){
                  morepageModel moremodel = snapshot.data[index];
                  return pagetile(
                    name: moremodel.slug.toString(),
                    id:moremodel.page_id.toString(),
                  );
                },
              );
            }
            return Center(
              child: SpinKitFadingCircle(
                color: mainaccent,
                size: 50.0,
                controller: AnimationController(
                    vsync: this, duration: const Duration(milliseconds: 1200)),
              ),
            );
          },
        ),
      ),
    );
  }
}

class pagetile extends StatelessWidget {
  String name, id;

  pagetile({this.name, this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8,left: 5,right: 5),
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFA),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 3,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ListTile(
        focusColor: mainaccent,
        title: Text(
          name,
          style: TextStyleFormBlack,
        ),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => pagedetail(id: id,),
            ),
          );
        },
      ),
    );
  }
}
