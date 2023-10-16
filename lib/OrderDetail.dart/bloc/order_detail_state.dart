// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_detail_bloc.dart';

@immutable
sealed class OrderDetailState {}

final class OrderDetailInitial extends OrderDetailState {}

class SOrderDetailLoaing extends OrderDetailState {}

class SOrderDetailVnpay extends OrderDetailState {
  VnpayModel vnpay;
  SOrderDetailVnpay({
    required this.vnpay,
  });
}

class SOrderClear extends OrderDetailState {}
