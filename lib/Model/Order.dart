// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:login/Model/Bill.dart';

import 'Item.dart';

class OrderModel {
  int id;
  String ngay;
  int sl;
  Item item;
  Bill bill;
  OrderModel({
    required this.id,
    required this.ngay,
    required this.sl,
    required this.item,
    required this.bill,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ngay': ngay,
      'sl': sl,
      'item': item.toMap(),
      'bill': bill.toMap(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as int,
      ngay: map['ngay'] as String,
      sl: map['sl'] as int,
      item: Item.fromMap(map['item'] as Map<String, dynamic>),
      bill: Bill.fromMap(map['bill'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
