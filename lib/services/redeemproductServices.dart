import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sbazarapp/models/productmodel.dart';

class redeemproductServices{


  List<productmodel> redeemfromJson(String jsonstring) {
    final data = json.decode(jsonstring);
    return List<productmodel>.from(
      data['redeem_products'].map(
            (item) => productmodel.fromJson(item),
      ),
    );
  }

  Future<List<productmodel>> getredeemProducts() async {
    String GET_URL = "http://www.sbazar.gmbh/public/api/products_points_redeem";
    final response = await http.post(GET_URL);
    if (response.statusCode == 200) {
      List<productmodel> list = redeemfromJson(response.body);
      return list;
    } else {
      return List<productmodel>();
    }
  }
}