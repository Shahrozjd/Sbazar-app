import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sbazarapp/models/forgotpassModel.dart';


class forgotpassServices{

  static const ADD_URL = "http://www.sbazar.gmbh/api/forgetpass";

  Future<String> forgotpass(forgotpassmodel fpmodel)async{
    final response = await http.post(ADD_URL, body: fpmodel.toJsonAdd());
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