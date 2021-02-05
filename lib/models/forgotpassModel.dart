import 'dart:core';

class forgotpassmodel {

  dynamic email;


  forgotpassmodel(
      {this.email});

  Map<String, dynamic> toJsonAdd() {
    return {
      'email': email,
    };
  }

}
