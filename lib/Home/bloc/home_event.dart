// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

sealed class HomeEvent {}

class EHomeLogout extends HomeEvent {}

class EHomeGetAll extends HomeEvent {}

class EHomeGetCountCart extends HomeEvent {
  int id;
  EHomeGetCountCart({
    required this.id,
  });
}

class EHomeLoadMore extends HomeEvent {}

class EHomeGetCountOrder extends HomeEvent {
  int id;
  EHomeGetCountOrder({
    required this.id,
  });
}
