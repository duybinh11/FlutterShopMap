import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Shop {
  int id;
  String name;
  String address;
  String phone;
  String img;
  String follower;
  String descrip;
  Shop({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.img,
    required this.follower,
    required this.descrip,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'img': img,
      'follower': follower,
      'descrip': descrip,
    };
  }

  factory Shop.fromMap(Map<String, dynamic> map) {
    return Shop(
      id: map['id'] as int,
      name: map['name'] as String,
      address: map['address'] as String,
      phone: map['phone'] as String,
      img: map['img'] as String,
      follower: map['follower'] as String,
      descrip: map['descrip'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Shop.fromJson(String source) =>
      Shop.fromMap(json.decode(source) as Map<String, dynamic>);
}
