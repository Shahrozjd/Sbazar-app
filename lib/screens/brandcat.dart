import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:sbazarapp/components/MainAppbBar.dart';
import 'package:sbazarapp/components/constants.dart';
import 'package:sbazarapp/models/BrandModel.dart';
import 'package:sbazarapp/services/BrandServices.dart';

class brandcatpage extends StatefulWidget {
  @override
  _brandcatpageState createState() => _brandcatpageState();
}

class _brandcatpageState extends State<brandcatpage> with TickerProviderStateMixin{
  Box pointbox = Hive.box('pointdata');
  int pointboxkeypoint = 105;
  int point;

  @override
  void initState() {
    point = pointbox.get(pointboxkeypoint, defaultValue: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(
        appBar: AppBar(),
        point: point,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 5,right: 5,bottom: 5,top: 10),
        child: FutureBuilder(
          future: BrandServices().getBrands(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  BrandModel brandModel = snapshot.data[index];
                  return gridcards(
                    title: brandModel.name.toString(),
                    imagepath:
                    'http://www.sbazar.gmbh/public/' +
                        brandModel.path,
                    ontap: () {

                    },
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

class gridcards extends StatelessWidget {
  String imagepath;
  String title = "title";
  Function ontap;

  gridcards({this.imagepath, this.title, this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: mainaccent.withOpacity(0.2),
      onTap: ontap,
      child: Container(
//        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 7,
              child: Image.network(imagepath),
            ),
            SizedBox(height: 10,),
            Expanded(
              flex: 3,
              child: Text(title,style: TextStyleFormBlackBold,textAlign: TextAlign.center,),
            )
          ],
        ),
      ),
    );
  }
}
