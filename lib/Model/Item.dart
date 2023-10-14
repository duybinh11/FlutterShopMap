import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Item {
  int id;
  String name;
  int cost;
  String img;
  String descrip;
  Item({
    required this.id,
    required this.name,
    required this.cost,
    required this.img,
    required this.descrip,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'cost': cost,
      'img': img,
      'descrip': descrip,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as int,
      name: map['name'] as String,
      cost: map['cost'] as int,
      img: map['img'] as String,
      descrip: map['descrip'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) =>
      Item.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Item(id: $id, name: $name, cost: $cost, img: $img, descrip: $descrip)';
  }
}
