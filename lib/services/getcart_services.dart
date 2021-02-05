import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sbazarapp/models/getcart_model.dart';


class getcart_services {

  static int  length;

  List<getcart_model> cartfromJson(String jsonstring) {
    final data = json.decode(jsonstring);
    print(data['cartproducts']);
    length = data['cartproducts'].length;
    return List<getcart_model>.from(
      data['cartproducts'].map(
            (item) => getcart_model.fromJson(item),

      ),
    );
  }

  Future<List<getcart_model>> getAllCart(getcart_model getcartmodel) async {
    String GET_URL = "http://www.sbazar.gmbh/public/api/getAllcartPro";
    final response = await http.post(GET_URL,body: getcartmodel.toJsonAdd());
    if (response.statusCode == 200) {
      List<getcart_model> list = cartfromJson(response.body);
      return list;
    } else {
      return List<getcart_model>();
    }
  }
}
