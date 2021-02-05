import 'dart:core';

class hotcatModel {

  dynamic hotcat_id;
  dynamic hotcat_name;
  dynamic image_of_hotcat;


  hotcatModel({this.hotcat_id, this.hotcat_name, this.image_of_hotcat});

  factory hotcatModel.fromJson(Map<String, dynamic> json) {
    return hotcatModel(
      hotcat_id: json['hotcat_id'],
      hotcat_name: json['hotcat_name'],
      image_of_hotcat: json['image_of_hotcat'],
    );
  }

//  Map<String, dynamic> toJsonAdd() {
//    return {
//      'hotcat_id'
//      'categories_slug': categories_name,
//      'parent_id': parent_id  ,
//    };
//  }
}
