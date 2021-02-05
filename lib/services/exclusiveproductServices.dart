import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sbazarapp/models/productmodel.dart';

class exclusiveproductServices{


  List<productmodel> exclusivefromJson(String jsonstring) {
    final data = json.decode(jsonstring);
    return List<productmodel>.from(
      data['exclusive_products'].map(
            (item) => productmodel.fromJson(item),
      ),
    );
  }

  Future<List<productmodel>> getExclusiveProducts() async {
    String GET_URL = "http://www.sbazar.gmbh/public/api/exclusiveproducts";
    final response = await http.post(GET_URL);
    if (response.statusCode == 200) {
      List<productmodel> list = exclusivefromJson(response.body);
      return list;
    } else {
      return List<productmodel>();
    }
  }
}