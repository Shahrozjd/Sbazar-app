import 'dart:core';

class morepageModel {

  dynamic page_id;
  dynamic slug;
  dynamic status;


  morepageModel({this.page_id, this.slug, this.status});

  factory morepageModel.fromJson(Map<String, dynamic> json) {
    return morepageModel(
        page_id: json['page_id'],
        slug: json['slug'],
        status: json['status'],
    );
  }

//  Map<String, dynamic> toJsonAdd() {
//    return {
//      "name":name,
//    };
//  }
}
