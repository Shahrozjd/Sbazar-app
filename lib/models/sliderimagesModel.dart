import 'dart:core';

class sliderimageModel {

  dynamic sliders_id;
  dynamic image_of_slider;


  sliderimageModel({this.sliders_id, this.image_of_slider});

  factory sliderimageModel.fromJson(Map<String, dynamic> json) {
    return sliderimageModel(
      sliders_id: json['sliders_id'],
      image_of_slider: json['image_of_slider'],
    );
  }

  Map<String, dynamic> toJsonAdd() {
    return {
      'sliders_id': sliders_id,
      'image_of_slider': image_of_slider,
    };
  }
}
