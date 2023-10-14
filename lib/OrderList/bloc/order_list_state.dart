// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_list_bloc.dart';

@immutable
sealed class OrderListState {}

final class OrderListInitial extends OrderListState {}

final class SOrderListLoading extends OrderListState {}

// ignore: must_be_immutable
class SOrderListGetAll extends OrderListState {
  List<OrderModel> list;
  SOrderListGetAll({
    required this.list,
  });
}
