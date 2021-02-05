import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sbazarapp/models/BrandModel.dart';

class BrandServices {
  static const GET_URL = "http://www.sbazar.gmbh/api/manufacturers";

  List<BrandModel> brandfromJson(String jsonstring) {
    final data = json.decode(jsonstring);
    print(data['manufacturers']);
    return List<BrandModel>.from(
      data['manufacturers'].map(
            (item) => BrandModel.fromJson(item),

      ),
    );
  }

  Future<List<BrandModel>> getBrands() async {
    final response = await http.post(GET_URL);

    if (response.statusCode == 200) {
      List<BrandModel> list = brandfromJson(response.body);
      return list;
    } else {
      return List<BrandModel>();
    }
  }
}
