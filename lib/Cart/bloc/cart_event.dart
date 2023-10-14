// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';


sealed class CartEvent {}

// ignore: must_be_immutable
class ECartGetAll extends CartEvent {
  int id;
  ECartGetAll({
    required this.id,
  });
}

// ignore: must_be_immutable
class ECartDelete extends CartEvent {
  int id;
  ECartDelete({
    required this.id,
  });
}
