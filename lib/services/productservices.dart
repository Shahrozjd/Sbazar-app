import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sbazarapp/models/productmodel.dart';

class productservices {


  List<productmodel> productfromJson(String jsonstring) {
    final data = json.decode(jsonstring);
    return List<productmodel>.from(
      data['category_products'].map(
            (item) => productmodel.fromJson(item),

      ),
    );
  }

  Future<List<productmodel>> getProduct(String cat_id) async {
    String GET_URL = "http://www.sbazar.gmbh/public/api/catproducts?cat_id="+cat_id;
    final response = await http.post(GET_URL);
    if (response.statusCode == 200) {
      List<productmodel> list = productfromJson(response.body);
      return list;
    } else {
      return List<productmodel>();
    }
  }
}
