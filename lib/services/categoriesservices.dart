import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sbazarapp/models/categoriesmodel.dart';

class categoriesservices {
  static const GET_URL = "http://www.sbazar.gmbh/public/api/parentcategories";

  List<categoriesmodel> categoriesfromJson(String jsonstring) {
    final data = json.decode(jsonstring);
    print(data['parent_categories']);
    return List<categoriesmodel>.from(
      data['parent_categories'].map(
        (item) => categoriesmodel.fromJson(item),

      ),
    );
  }

  Future<List<categoriesmodel>> getCategories() async {
    final response = await http.post(GET_URL);

    if (response.statusCode == 200) {
      List<categoriesmodel> list = categoriesfromJson(response.body);
      return list;
    } else {
      return List<categoriesmodel>();
    }
  }
}
