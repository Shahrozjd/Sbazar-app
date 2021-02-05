import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sbazarapp/models/cart_model.dart';


class cart_services {





  Future<String> addtocart(cart_model addtocartmodel) async {

    String GET_URL = "http://www.sbazar.gmbh/public/api/addtocart";
    final response = await http.post(GET_URL,body: addtocartmodel.toJsonAdd());
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "ERROR";
    }
  }
  Future<String> removefromcart(cart_model addtocartmodel) async {

    String GET_URL = "http://www.sbazar.gmbh/public/api/removeCart";
    final response = await http.post(GET_URL,body: addtocartmodel.toJsonAdd());
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "ERROR";
    }
  }
  Future<String> addquantcart(cart_model addtocartmodel) async {

    String GET_URL = "http://www.sbazar.gmbh/public/api/addqty";
    final response = await http.post(GET_URL,body: addtocartmodel.toJsonAddQuant());
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "ERROR";
    }
  }
}
