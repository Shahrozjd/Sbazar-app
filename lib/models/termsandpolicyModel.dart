class termsandpolicyModel {
  dynamic name;
  dynamic description;


  termsandpolicyModel({this.name, this.description});

  factory termsandpolicyModel.fromJson(Map<String, dynamic> json) {
    return termsandpolicyModel(
      name: json['name'],
      description: json['description'],
    );
  }


}
