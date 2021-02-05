import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sbazarapp/models/morepageModel.dart';


class morepageServices {

  static int  length;

  List<morepageModel> pagesfromJson(String jsonstring) {
    final data = json.decode(jsonstring);
    print(data['pages']);
    length = data['pages'].length;
    return List<morepageModel>.from(
      data['pages'].map(
            (item) => morepageModel.fromJson(item),

      ),
    );
  }

  Future<List<morepageModel>> getAllPages() async {
    String GET_URL = "http://www.sbazar.gmbh/public/api/allpages";
    final response = await http.post(GET_URL);
    if (response.statusCode == 200) {
      List<morepageModel> list = pagesfromJson(response.body);
      return list;
    } else {
      return List<morepageModel>();
    }
  }
}
