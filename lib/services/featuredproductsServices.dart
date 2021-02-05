import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sbazarapp/models/productmodel.dart';

class featuredproductServices{


  List<productmodel> featuredfromJson(String jsonstring) {
    final data = json.decode(jsonstring);
    return List<productmodel>.from(
      data['featured_products'].map(
            (item) => productmodel.fromJson(item),
      ),
    );
  }

  Future<List<productmodel>> getfeaturedProducts() async {
    String GET_URL = "http://www.sbazar.gmbh/public/api/featuredproducts";
    final response = await http.post(GET_URL);
    if (response.statusCode == 200) {
      List<productmodel> list = featuredfromJson(response.body);
      return list;
    } else {
      return List<productmodel>();
    }
  }
}