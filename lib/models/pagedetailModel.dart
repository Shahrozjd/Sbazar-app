class pagedetailModel{
  dynamic page_id;
  dynamic description;
  dynamic name;


  pagedetailModel({this.page_id, this.description, this.name});

  factory pagedetailModel.fromJson(Map<String, dynamic> json) {
    return pagedetailModel(
      page_id: json['page_id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJsonAdd() {
    return {
      "page_id":page_id,
    };
  }

}