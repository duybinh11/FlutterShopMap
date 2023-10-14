// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:login/Model/Item.dart';

class CartModel {
  int id;
  String ngay;
  Item item;
  CartModel({
    required this.id,
    required this.ngay,
    required this.item,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ngay': ngay,
      'item': item.toMap(),
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'] as int,
      ngay: map['ngay'] as String,
      item: Item.fromMap(map['item'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
