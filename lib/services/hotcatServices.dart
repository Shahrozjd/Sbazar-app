import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sbazarapp/models/hotcatModel.dart';


class hotcatServices {
  static const GET_URL = "http://www.sbazar.gmbh/public/api/hotcat";

  List<hotcatModel> hotcatfromJson(String jsonstring) {
    final data = json.decode(jsonstring);
    print(data['hotcategories']);
    return List<hotcatModel>.from(
      data['hotcategories'].map(
            (item) => hotcatModel.fromJson(item),

      ),
    );
  }

  Future<List<hotcatModel>> getHotCategories() async {
    final response = await http.post(GET_URL);

    if (response.statusCode == 200) {
      List<hotcatModel> list = hotcatfromJson(response.body);
      return list;
    } else {
      return List<hotcatModel>();
    }
  }
}
