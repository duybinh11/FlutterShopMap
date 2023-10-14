// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class SHomeLoading extends HomeState {}

// ignore: must_be_immutable
class SHomeLogout extends HomeState {
  bool result;
  SHomeLogout({
    required this.result,
  });
}

// ignore: must_be_immutable
class SHomeGetAll extends HomeState {
  List<Item> lists;
  SHomeGetAll({
    required this.lists,
  });
}

// ignore: must_be_immutable
class SHomeGetCountCart extends HomeState {
  int count;
  SHomeGetCountCart({
    required this.count,
  });
}

class SHomeGetCountOrder extends HomeState {
  int count;
  SHomeGetCountOrder({
    required this.count,
  });
}

class SHomeLoadMoreLoading extends HomeState {}

class SHomeLastPage extends HomeState {}
