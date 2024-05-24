class UserModel {
  String name;
  String email;
  String uid;
  String profile;
  String phone;
  String gender;

  UserModel({
    required this.gender,
    required this.phone,
    required this.name,
    required this.email,
    required this.uid,
    required this.profile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      gender: json['Gender'],
      phone: json['phone'],
      name: json['Name'], 
      email: json['Email'],
      uid: json['uid'],
      profile: json['profile'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name; 
    data['Email'] = this.email;
    data['uid'] = this.uid;
    data['profile'] = this.profile;
    data['Gender']=this.gender;
    data['phone']=this.phone;
    return data;
  }
}
