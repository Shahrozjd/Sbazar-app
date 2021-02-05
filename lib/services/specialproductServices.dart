import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sbazarapp/models/productmodel.dart';

class specialproductServices{


  List<productmodel> specialfromJson(String jsonstring) {
    final data = json.decode(jsonstring);
    return List<productmodel>.from(
      data['special products'].map(
            (item) => productmodel.fromJson(item),
      ),
    );
  }

  Future<List<productmodel>> getspecialProducts() async {
    String GET_URL = "http://www.sbazar.gmbh/public/api/specialproducts";
    final response = await http.post(GET_URL);
    if (response.statusCode == 200) {
      List<productmodel> list = specialfromJson(response.body);
      return list;
    } else {
      return List<productmodel>();
    }
  }
}