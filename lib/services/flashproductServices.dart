import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sbazarapp/models/productmodel.dart';

class flashproductServices{


  List<productmodel> flashfromJson(String jsonstring) {
    final data = json.decode(jsonstring);
    return List<productmodel>.from(
      data['flash_sale_products'].map(
            (item) => productmodel.fromJson(item),
      ),
    );
  }

  Future<List<productmodel>> getflashProducts() async {
    String GET_URL = "http://www.sbazar.gmbh/public/api/flashsaleproducts";
    final response = await http.post(GET_URL);
    if (response.statusCode == 200) {
      List<productmodel> list = flashfromJson(response.body);
      return list;
    } else {
      return List<productmodel>();
    }
  }
}