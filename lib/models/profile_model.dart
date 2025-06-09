import 'dart:convert';

ProfileModel profileModelFromJson(String str) {
  final jsonData = json.decode(str);
  return ProfileModel.fromJson(jsonData);
}

class ProfileModel {
  String? id;
  String? username;
  String? updatedAt;
  String? phonenumber;
  dynamic age;
  dynamic address;
  String? profileImage;

  ProfileModel({
    this.id,
    this.username,
    this.updatedAt,
    this.phonenumber,
    this.age,
    this.address,
    this.profileImage,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json["id"],
    username: json["username"],
    updatedAt: json["updated_at"],
    phonenumber: json["phonenumber"],
    age: json["age"],
    address: json["address"],
    profileImage: json["profile_image"],
  );
}
