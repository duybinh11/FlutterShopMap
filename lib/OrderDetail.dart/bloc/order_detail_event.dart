// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_detail_bloc.dart';

@immutable
sealed class OrderDetailEvent {}

class EOrderGetVnpay extends OrderDetailEvent {
  int idBill;
  EOrderGetVnpay({
    required this.idBill,
  });
}

class EOrderClearState extends OrderDetailEvent {}
