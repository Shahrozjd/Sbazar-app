import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sbazarapp/screens/mainpage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sbazarapp/screens/splashscreen.dart';
import 'components/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<int>('cart_items');
  await Hive.openBox<int>('cart_count');
  await Hive.openBox('logincheck');
  await Hive.openBox('pointdata');
  await Hive.openBox<bool>('added_product');
  await Hive.openBox<bool>('favproducts');
  await Hive.openBox<int>('added_product_quant');

  runApp(
      MyApp());
}

//this is used for DEVICE PREVIEW
//Future<void> main() async{
//  WidgetsFlutterBinding.ensureInitialized();
//  await Hive.initFlutter();
//  await Hive.openBox<int>('cart_items');
//  await Hive.openBox<int>('cart_count');
//  await Hive.openBox('logincheck');
//  await Hive.openBox('pointdata');
//  await Hive.openBox<bool>('added_product');
//  await Hive.openBox<bool>('favproducts');
//  await Hive.openBox<int>('added_product_quant');
//  runApp(
//    DevicePreview(
//      enabled: !kReleaseMode,
//      builder: (context) => MyApp(),
//    ),);
//}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _navigatorKey = GlobalKey<NavigatorState>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sbazar',
      theme: ThemeData.light().copyWith(
        primaryColor: mainaccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: splashscreen()
    );
  }
}
