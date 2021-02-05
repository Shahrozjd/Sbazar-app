import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:sbazarapp/models/customer_login_model.dart';

class customer_login_services{

  static const ADD_URL = "http://www.sbazar.gmbh/public/api/processlogin";

  Future<String> LoginCustomer(customer_login_model clogin_model)async{
    final response = await http.post(ADD_URL, body: clogin_model.toJsonAdd());
    if (response.statusCode == 200)
    {
      print(response.body);
      return response.body;
    }
    else{
      return "ERROR";
    }
  }

}