// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';


sealed class CartState {}

final class CartInitial extends CartState {}

final class SCartLoading extends CartState {}

class SCartGetAll extends CartState {
  List<CartModel> list;
  SCartGetAll({
    required this.list,
  });
}

class SCartDelete extends CartState {
  bool check;
  SCartDelete({
    required this.check,
  });
}
