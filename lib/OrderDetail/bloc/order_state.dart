// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class SOrderLoading extends OrderState {}

class SOrderGetItem extends OrderState {
  Item item;
  SOrderGetItem({
    required this.item,
  });
}

class SOrderBuyItem extends OrderState {
  bool check;
  SOrderBuyItem({
    required this.check,
  });
}
