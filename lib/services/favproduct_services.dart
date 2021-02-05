import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sbazarapp/models/favproduct_model.dart';



class favproduct_services {

  static int  length;

  List<favproduct_model> favproductsfromJson(String jsonstring) {
    final data = json.decode(jsonstring);
    print('fav products');
    print(data['fav products']);
    length = data['fav products'].length;
    return List<favproduct_model>.from(
      data['fav products'].map(
            (item) => favproduct_model.fromJson(item),

      ),
    );
  }

  Future<List<favproduct_model>> getAllFavProducts(favproduct_model favprodmodel) async {
    String GET_URL = "http://www.sbazar.gmbh/public/api/getfavproducts";
    final response = await http.post(GET_URL,body: favprodmodel.toJsonAddGET());
    if (response.statusCode == 200) {
      List<favproduct_model> list = favproductsfromJson(response.body);
      return list;
    } else {
      return List<favproduct_model>();
    }
  }
  Future<String> addFavProducts(favproduct_model favprodmodel) async {
    String GET_URL = "http://www.sbazar.gmbh/public/api/addfavproducts";
    final response = await http.post(GET_URL,body: favprodmodel.toJsonAddPOST());
    if (response.statusCode == 200) {
      print("add fav");
      return response.body;
    } else {
      return "ERROR";
    }
  }
  Future<String> delFavProducts(favproduct_model favprodmodel) async {
    String GET_URL = "http://www.sbazar.gmbh/public/api/deletefavproducts";
    final response = await http.post(GET_URL,body: favprodmodel.toJsonAddPOST());
    if (response.statusCode == 200) {
      print("del fav");
      return response.body;
    } else {
      return "ERROR";
    }
  }
}
