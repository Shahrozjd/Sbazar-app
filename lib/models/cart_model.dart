import 'dart:core';

class cart_model {

  dynamic products_id;
  dynamic products_price;
  dynamic products_weight;
  dynamic products_weight_unit;
  dynamic products_slug;
  dynamic image_of_product;
  dynamic products_quantity;
  dynamic email;


  cart_model({this.products_id,this.email,this.products_quantity});

//  factory getcart_model.fromJson(Map<String, dynamic> json) {
//    return getcart_model(
//      products_id: json['products_id'],
//      products_price: json['products_price'],
//      products_weight: json['products_weight'],
//      products_weight_unit: json['products_weight_unit'],
//      products_slug: json['products_slug'],
//      image_of_product: json['image_of_product'],
//    );
//  }

  Map<String, dynamic> toJsonAdd() {
    return {
      'email': email,
      'product_id':products_id,
    };
  }
  Map<String, dynamic> toJsonAddQuant() {
    return {
      'email': email,
      'product_id':products_id,
      'qty':products_quantity,
    };
  }
}
