
class customer_login_model{
  dynamic email;
  dynamic password;


  customer_login_model({this.email, this.password});

  factory customer_login_model.fromJson(Map<String,dynamic> json){
    return customer_login_model(
      email: json['email'],
      password: json['password']
    );
  }

  Map<String,dynamic> toJsonAdd(){
    return {
      'email':email,
      'password':password,
    };
  }

}