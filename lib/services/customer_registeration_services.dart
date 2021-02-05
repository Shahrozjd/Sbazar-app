import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sbazarapp/models/customer_registeration_model.dart';


class customer_registeration_services {

  static const ADD_URL = "http://www.sbazar.gmbh/public/api/processregistration";

  Future<String> RegisterCustomer(customer_registeration_model creg_model)async{
    final response = await http.post(ADD_URL, body: creg_model.toJsonAdd());
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
