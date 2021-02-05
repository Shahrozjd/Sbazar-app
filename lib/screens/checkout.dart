import 'package:flutter/material.dart';
import 'package:sbazarapp/components/DarkTextField.dart';
import 'package:sbazarapp/components/RectButton.dart';
import 'package:sbazarapp/components/RectButtonAlt.dart';
import 'package:sbazarapp/components/constants.dart';
import 'package:sbazarapp/models/customer_registeration_model.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'cardexample.dart';

class checkoutpage extends StatefulWidget {
  @override
  _checkoutpageState createState() => _checkoutpageState();
}

class _checkoutpageState extends State<checkoutpage> {
  var add = TextEditingController();
  bool checkadd = false;
  int currentsteps = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Checkout',
            style: TextStyleMediumBlack,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        body: Container(
          child: Column(
            children: [
              StepProgressIndicator(
                totalSteps: 3,
                currentStep: currentsteps,
                size: 30,
                selectedColor: mainaccent,
                unselectedColor: Colors.grey[200],
                customStep: (index, color, _) => color == mainaccent
                    ? Container(
                        color: color,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      )
                    : Container(
                        color: color,
                        child: Icon(
                          Icons.remove,
                        ),
                      ),
              ),
              if (currentsteps == 1) Info(context),
              if (currentsteps == 2) preview(context),
              if (currentsteps == 3) payment(),

            ],
          ),
        ));
  }

  Widget payment() {
    return Container(height: 600, child: cardexample());
  }


  //Info UI
  Widget Info(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Information',
            style: TextStyleHeadingBlackBold,
          ),
          SizedBox(
            height: 5,
          ),
          DarkTextField(
              hintext: 'First Name', obscuretext: false, hasfocus: false),
          SizedBox(
            height: 5,
          ),
          DarkTextField(
              hintext: 'Last Name', obscuretext: false, hasfocus: false),
          SizedBox(
            height: 5,
          ),
          DarkTextField(hintext: 'Phone', obscuretext: false, hasfocus: false),
          SizedBox(
            height: 5,
          ),
          DarkTextField(hintext: 'email', obscuretext: false, hasfocus: false),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: mainaccent,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Address',
                style: TextStyleFormBlackBold,
              ),
              Material(
                  child: InkWell(
                      onTap: () {},
                      splashColor: Colors.black.withOpacity(0.2),
                      child: Text(
                        'Change>',
                        style: TextStyleFormAccent,
                      ))),
            ],
          ),
          DarkTextField(hintext: 'street address', obscuretext: false, hasfocus: true),
          DarkTextField(hintext: 'city', obscuretext: false, hasfocus: false),
          DarkTextField(hintext: 'zip code', obscuretext: false, hasfocus: false),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: mainaccent,
          ),
          Text(
            'Shipping',
            style: TextStyleFormBlackBold,
          ),
          Row(
            children: [
              Expanded(
                child: RectButtonAlt(
                  textval: 'Back',
                  onpress: () {
                    setState(() {
                      currentsteps -= 1;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: RectButton(
                  textval: 'Next',
                  onpress: () {
                    setState(() {
                      currentsteps += 1;
                    });
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget preview(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text("PREVIEW"),
        ),
        Row(
          children: [
            Expanded(
              child: RectButtonAlt(
                textval: 'Back',
                onpress: () {
                  setState(() {
                    currentsteps -= 1;
                  });
                },
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: RectButton(
                textval: 'Next',
                onpress: () {
                  setState(() {
                    currentsteps += 1;
                  });
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
