import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sbazarapp/models/bottombarModel.dart';

class bottombarServices{


  List<bottombarModel> BottombarfromJson(String jsonstring) {
    final data = json.decode(jsonstring);
    return List<bottombarModel>.from(
      data['app_menus_bottom'].map(
            (item) => bottombarModel.fromJson(item),

      ),
    );
  }

  Future<List<bottombarModel>> getBottombar() async {
    String GET_URL = "http://www.sbazar.gmbh/public/api/app_menus_bottom";
    final response = await http.post(GET_URL);
    if (response.statusCode == 200) {
      List<bottombarModel> list = BottombarfromJson(response.body);
      return list;
    } else {
      return List<bottombarModel>();
    }
  }
}