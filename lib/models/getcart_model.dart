import 'dart:core';

class getcart_model {

  dynamic products_id;
  dynamic products_price;
  dynamic products_weight;
  dynamic products_weight_unit;
  dynamic cart_quantity;
  dynamic products_name;
  dynamic image_of_product;
  String email;


  getcart_model({this.products_id, this.products_price, this.products_weight,
      this.products_weight_unit, this.products_name, this.image_of_product,this.email,this.cart_quantity});

  factory getcart_model.fromJson(Map<String, dynamic> json) {
    return getcart_model(
      products_id: json['products_id'],
      products_price: json['products_price'],
      products_weight: json['products_weight'],
      products_weight_unit: json['products_weight_unit'],
      products_name: json['products_name'],
      image_of_product: json['image_of_product'],
      cart_quantity: json['cart_quantity'],
    );
  }

  Map<String, dynamic> toJsonAdd() {
    return {
      'email': email,
    };
  }
}
