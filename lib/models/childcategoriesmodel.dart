import 'dart:core';

class childcategoriesmodel {

  dynamic categories_id;
  String categories_slug;
  dynamic parent_id;
  dynamic categories_name;
  int length;

  childcategoriesmodel({this.categories_id, this.categories_slug, this.parent_id,this.categories_name});

  factory childcategoriesmodel.fromJson(Map<String, dynamic> json) {
    return childcategoriesmodel(
      categories_id: json['categories_id'],
      categories_slug: json['categories_slug'],
      parent_id: json['parent_id'],
      categories_name: json['categories_name'],
    );
  }


  Map<String, dynamic> toJsonAdd() {
    return {
      'categories_id': categories_id,
      'categories_slug': categories_slug,
      'parent_id': parent_id  ,
    };
  }
}
