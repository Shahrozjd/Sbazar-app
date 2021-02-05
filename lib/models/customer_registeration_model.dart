import 'dart:core';

class customer_registeration_model {

  dynamic customers_firstname;
  dynamic customers_lastname;
  dynamic email;
  dynamic password;
  dynamic customers_telephone;
  dynamic ref_id;


  customer_registeration_model({
      this.customers_firstname,
      this.customers_lastname,
      this.email,
      this.password,
      this.customers_telephone,
      this.ref_id,
  });

  factory customer_registeration_model.fromJson(Map<String, dynamic> json) {
    return customer_registeration_model(
      customers_firstname: json['customers_firstname'],
      customers_lastname: json['customers_lastname'],
      email: json['email'],
      password: json['password'],
      customers_telephone: json['customers_telephone'],
    );
  }

  Map<String, dynamic> toJsonAdd() {
    return {
      "customers_firstname": customers_firstname,
      "customers_lastname": customers_lastname,
      "email": email,
      "password": password,
      "customers_telephone": customers_telephone,
      "ref_id":ref_id
    };
  }
}
