import 'dart:core';

class categoriesmodel {

  dynamic categories_id;
  String categories_name;
  dynamic parent_id;
  dynamic icon_of_category;



  categoriesmodel({this.categories_id, this.categories_name, this.parent_id,this.icon_of_category});

  factory categoriesmodel.fromJson(Map<String, dynamic> json) {
    return categoriesmodel(
      categories_id: json['categories_id'],
      categories_name: json['categories_name'],
      parent_id: json['parent_id'],
      icon_of_category: json['icon_of_category'],
    );
  }

  Map<String, dynamic> toJsonAdd() {
    return {
      'categories_id': categories_id,
      'categories_slug': categories_name,
      'parent_id': parent_id  ,
    };
  }
}
