// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_list_bloc.dart';

@immutable
sealed class OrderListEvent {}

// ignore: must_be_immutable
class EOrderListGetAllOrder extends OrderListEvent {
  int id;
  EOrderListGetAllOrder({
    required this.id,
  });
}
