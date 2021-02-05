import 'dart:convert';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sbazarapp/models/userprofile_model.dart';

class userprofile_services {


  userprofile_model profilefromJson(String jsonstring) {
    final data = json.decode(jsonstring);
    print(data['data'][0].toString());
    return userprofile_model.fromJson(data['data'][0]);
  }

  Future<userprofile_model> getUserProfile(userprofile_model userprof) async {
    String GET_URL = "http://www.sbazar.gmbh/public/api/authuser";
    final response = await http.post(GET_URL,body: userprof.toJsonAddFetch());
    if (response.statusCode == 200) {
      userprofile_model userprof = profilefromJson(response.body);
      return userprof;
    } else {
      return userprofile_model();
    }
  }

  Future<String> UpdateUserProfile(userprofile_model userprof) async {
    String GET_URL = "http://www.sbazar.gmbh/public/api/updateAuthUser";
    final response = await http.post(GET_URL,body: userprof.toJsonAddUpdate());
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "ERROR";
    }
  }
  Future<String> UpdateUserPassword(userprofile_model userprof) async {
    String GET_URL = "http://www.sbazar.gmbh/public/api/updateAuthUser";
    final response = await http.post(GET_URL,body: userprof.toJsonAddUpdatePassword());
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "ERROR";
    }
  }
}
