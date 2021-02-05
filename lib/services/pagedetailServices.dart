import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sbazarapp/models/pagedetailModel.dart';


class pagedetailServices {


  pagedetailModel pagesfromJson(String jsonstring) {
    final data = json.decode(jsonstring);
    print(data['current_page']);
    return pagedetailModel.fromJson(data['current_page']);
  }

  Future<pagedetailModel> getAllPages(pagedetailModel pagedetailmodel) async {
    String GET_URL = "http://www.sbazar.gmbh/public/api/getpages";
    final response = await http.post(GET_URL,body: pagedetailmodel.toJsonAdd());
    if (response.statusCode == 200) {
      pagedetailModel pagemodel = pagesfromJson(response.body);
      return pagemodel;
    } else {
      return pagedetailModel();
    }
  }
}
