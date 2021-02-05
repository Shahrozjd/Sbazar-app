import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sbazarapp/models/productmodel.dart';

class newproductServices{


  List<productmodel> newfromJson(String jsonstring) {
    final data = json.decode(jsonstring);
    return List<productmodel>.from(
      data['recently added'].map(
            (item) => productmodel.fromJson(item),
      ),
    );
  }

  Future<List<productmodel>> getNewProducts() async {
    String GET_URL = "http://www.sbazar.gmbh/public/api/recentproducts";
    final response = await http.post(GET_URL);
    if (response.statusCode == 200) {
      List<productmodel> list = newfromJson(response.body);
      return list;
    } else {
      return List<productmodel>();
    }
  }
}