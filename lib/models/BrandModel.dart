import 'dart:core';

class BrandModel {

  dynamic manufacturers_id;
  dynamic name;
  dynamic manufacturers_desc;
  dynamic path;


  BrandModel({this.manufacturers_id, this.name,
      this.manufacturers_desc, this.path});

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      manufacturers_id: json['manufacturers_id'],
      name: json['name'],
      manufacturers_desc: json['manufacturers_desc'],
      path: json['path'],
    );
  }

}
