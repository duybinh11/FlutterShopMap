import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Bill {
  int id;
  String pay;
  bool statusPay;
  String? ngayPay;
  Bill({
    required this.id,
    required this.pay,
    required this.statusPay,
    this.ngayPay,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'pay': pay,
      'statusPay': statusPay,
      'ngayPay': ngayPay,
    };
  }

  factory Bill.fromMap(Map<String, dynamic> map) {
    return Bill(
      id: map['id'] as int,
      pay: map['pay'] as String,
      statusPay: map['status_pay'] != 0,
      ngayPay: map['ngay_pay'] != null ? map['ngay_pay'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Bill.fromJson(String source) =>
      Bill.fromMap(json.decode(source) as Map<String, dynamic>);
}
