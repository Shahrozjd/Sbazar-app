class userprofile_model {
  dynamic first_name;
  dynamic last_name;
  dynamic gender;
  dynamic phone;
  dynamic dob;
  dynamic spoints;
  dynamic ppoints;
  dynamic email;
  dynamic referral_id;
  dynamic password;



  userprofile_model({this.first_name, this.last_name, this.gender, this.phone,
      this.spoints, this.ppoints, this.email,this.dob,this.referral_id,this.password});

  factory userprofile_model.fromJson(Map<String, dynamic> json) {
    return userprofile_model(
      first_name: json['first_name'],
      last_name: json['last_name'],
      email: json['email'],
      spoints: json['spoints'],
      ppoints: json['ppoints'],
      gender: json['gender'],
      phone: json['phone'],
      dob: json['dob'],
      referral_id: json['referral_id'],
    );
  }

  Map<String,dynamic> toJsonAddFetch()
  {
    return {
      'email':email,
//      'first_name':first_name,
//      'last_name':last_name,
//      'phone':phone,
//      'gender':gender,
//      'dob':dob,
    };
  }

  Map<String,dynamic> toJsonAddUpdate()
  {
    return {
      'email':email,
      'first_name':first_name,
      'last_name':last_name,
      'phone':phone,
      'gender':gender,
      'dob':dob,
    };
  }
  Map<String,dynamic> toJsonAddUpdatePassword()
  {
    return {
      'email':email,
      'password':password,
    };
  }
}
