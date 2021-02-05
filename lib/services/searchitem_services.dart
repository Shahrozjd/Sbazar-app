import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sbazarapp/models/searchitem_model.dart';


class searchitem_services {

  static int  length;

  List<searchitem_model> searchitemfromJson(String jsonstring) {
    final data = json.decode(jsonstring);
    print(data['searched_products']);
    length = data['searched_products'].length;
    return List<searchitem_model>.from(
      data['searched_products'].map(
            (item) => searchitem_model.fromJson(item),

      ),
    );
  }

  Future<List<searchitem_model>> getAllCart(searchitem_model searchmodel) async {
    String GET_URL = "http://www.sbazar.gmbh/public/api/getfilterproducts";
    final response = await http.post(GET_URL,body: searchmodel.toJsonAdd());
    if (response.statusCode == 200) {
      List<searchitem_model> list = searchitemfromJson(response.body);
      return list;
    } else {
      return List<searchitem_model>();
    }
  }
}
