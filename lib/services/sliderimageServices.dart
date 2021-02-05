import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sbazarapp/models/sliderimagesModel.dart';

class sliderimageServices{
  static int  length;

  List<sliderimageModel> slidersfromJson(String jsonstring) {
    final data = json.decode(jsonstring);
    print(data['sliders']);
    length = data['sliders'].length;
    return List<sliderimageModel>.from(
      data['sliders'].map(
            (item) => sliderimageModel.fromJson(item),

      ),
    );
  }

  Future<List<sliderimageModel>> getAllSliders() async {
    String GET_URL = "http://www.sbazar.gmbh/public/api/sliderimages";
    final response = await http.post(GET_URL);
    if (response.statusCode == 200) {
      List<sliderimageModel> list = slidersfromJson(response.body);
      return list;
    } else {
      return List<sliderimageModel>();
    }
  }
}