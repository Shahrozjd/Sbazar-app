import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sbazarapp/models/termsandpolicyModel.dart';

class termsandpolicyServices{


  termsandpolicyModel termsfromJson(String jsonstring) {
    final data = json.decode(jsonstring);
    return termsandpolicyModel.fromJson(data['terms']);
  }

  Future<termsandpolicyModel> getterms() async {
    String GET_URL = "http://www.sbazar.gmbh/public/api/terms";
    final response = await http.post(GET_URL);
    if (response.statusCode == 200) {
      termsandpolicyModel model = termsfromJson(response.body);
      return model;
    } else {
      return termsandpolicyModel();
    }
  }
  termsandpolicyModel privacyfromJson(String jsonstring) {
    final data = json.decode(jsonstring);
    return termsandpolicyModel.fromJson(data['privacy'][0]);
  }

  Future<termsandpolicyModel> getprivacy() async {
    String GET_URL = "http://www.sbazar.gmbh/public/api/privacy";
    final response = await http.post(GET_URL);
    if (response.statusCode == 200) {
      termsandpolicyModel model = privacyfromJson(response.body);
      return model;
    } else {
      return termsandpolicyModel();
    }
  }
}