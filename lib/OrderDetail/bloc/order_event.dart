// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

// ignore: must_be_immutable
class EOrderGetPay extends OrderEvent {
  String? pay;
  EOrderGetPay({
    required this.pay,
  });
}

class EOrderBuy extends OrderEvent {
  int idUser;
  int idItem;
  int sl;

  String? pay;
  EOrderBuy(
      {required this.idUser,
      required this.idItem,
      required this.sl,
      required this.pay});
}
