class menubarModel{

  dynamic bg_image;
  dynamic title;


  menubarModel({this.bg_image, this.title});

  factory menubarModel.fromJson(Map<String,dynamic> json){
    return menubarModel(
      bg_image: json['bg_image'],
      title: json['title'],
    );
  }

}