import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class VnpayModel {
  int id;
  int idBill;
  int? cost;
  String? bankCode;
  String ngay;
  VnpayModel({
    required this.id,
    required this.idBill,
    this.cost,
    this.bankCode,
    required this.ngay,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'id_bill': idBill,
      'cost': cost,
      'bank_code': bankCode,
      'ngay': ngay,
    };
  }

  factory VnpayModel.fromMap(Map<String, dynamic> map) {
    return VnpayModel(
      id: map['id'] as int,
      idBill: map['id_bill'] != null ? map['id_bill'] as int : 0,
      cost: map['cost'] != null ? map['cost'] as int : null,
      bankCode: map['bank_code'] != null ? map['bank_code'] as String : null,
      ngay: map['ngay'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VnpayModel.fromJson(String source) =>
      VnpayModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
