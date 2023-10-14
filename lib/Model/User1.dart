import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User1 {
  int id;
  String email;
  String username;
  String token;
  String address;
  String phone;
  String? img;
  User1(
      {required this.id,
      required this.email,
      required this.username,
      required this.token,
      required this.address,
      required this.phone,
      this.img});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'username': username,
      'token': token,
      'address': address,
      'phone': phone,
      'img': img,
    };
  }

  factory User1.fromMap(Map<String, dynamic> map) {
    return User1(
      id: map['id'] as int,
      email: map['email'] as String,
      username: map['username'] as String,
      token: map['token'] as String,
      address: map['address'] as String,
      phone: map['phone'] as String,
      img: map['img'] != null ? map['img'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User1.fromJson(String source) =>
      User1.fromMap(json.decode(source) as Map<String, dynamic>);
}
