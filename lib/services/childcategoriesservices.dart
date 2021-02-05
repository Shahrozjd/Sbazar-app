import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sbazarapp/models/childcategoriesmodel.dart';

class childcategoriesservices {

  static int  length;

  List<childcategoriesmodel> childcategoriesfromJson(String jsonstring) {
    final data = json.decode(jsonstring);
    length = data['child_categories'].length;
    return List<childcategoriesmodel>.from(
      data['child_categories'].map(
            (item) => childcategoriesmodel.fromJson(item),

      ),
    );
  }




  Future<List<childcategoriesmodel>> getCategories(String parentid) async {

    String GET_URL = "http://www.sbazar.gmbh/public/api/childcategories?parent_id="+parentid;
    final response = await http.post(GET_URL);

    if (response.statusCode == 200) {
      List<childcategoriesmodel> list = childcategoriesfromJson(response.body);
      length = list.length;
      return list;
    } else {
      return List<childcategoriesmodel>();
    }
  }
}
