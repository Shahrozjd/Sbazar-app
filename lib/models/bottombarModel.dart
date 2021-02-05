class bottombarModel{

  dynamic icon;
  dynamic title;


  bottombarModel({this.icon, this.title});

  factory bottombarModel.fromJson(Map<String,dynamic> json){
    return bottombarModel(
      icon: json['icon'],
      title: json['title'],
    );
  }

}