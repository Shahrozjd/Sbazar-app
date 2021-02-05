import 'dart:core';

class favproduct_model {

  dynamic products_id;
  dynamic products_price;
  dynamic products_weight;
  dynamic products_weight_unit;
  dynamic products_name;
  dynamic parent_products_id;
  dynamic products_price_market;
  dynamic products_points;
  dynamic image_of_product;
  dynamic products_status;
  dynamic products_description;
  dynamic products_sku;
  dynamic email;

  favproduct_model({this.products_id, this.products_price, this.products_weight,
    this.products_weight_unit, this.products_name, this.parent_products_id,
    this.products_price_market,this.products_points,this.products_status,
    this.image_of_product,this.products_description,this.products_sku,this.email});

  factory favproduct_model.fromJson(Map<String, dynamic> json) {
    return favproduct_model(
      products_id: json['products_id'],
      products_price: json['products_price'],
      products_weight: json['products_weight'],
      products_weight_unit: json['products_weight_unit'],
      products_name: json['products_name'],
      parent_products_id: json['parent_products_id'],
      image_of_product: json['image_of_product'],
      products_price_market: json['products_price_market'],
      products_points: json['products_points'],
      products_status: json['products_status'],
      products_description: json['products_description'],
      products_sku: json['products_sku'],
    );
  }

  Map<String, dynamic> toJsonAddPOST() {
    return {
      'email':email,
      'product_id': products_id  ,
    };
  }
  Map<String, dynamic> toJsonAddGET() {
    return {
      'email':email,
    };
  }
}
