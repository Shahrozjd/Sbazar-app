import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sbazarapp/models/menubarModel.dart';

class menubarServices{

  static String image_string;

  List<menubarModel> menubarfromJson(String jsonstring) {
    final data = json.decode(jsonstring);
    image_string = data['welcome_image']["value"];
    return List<menubarModel>.from(
      data['app_menus_main'].map(
            (item) => menubarModel.fromJson(item),

      ),
    );
  }

  Future<List<menubarModel>> getMenubar() async {
    String GET_URL = "http://www.sbazar.gmbh/public/api/app_menus_main";
    final response = await http.post(GET_URL);
    if (response.statusCode == 200) {
      List<menubarModel> list = menubarfromJson(response.body);
      return list;
    } else {
      return List<menubarModel>();
    }
  }
}