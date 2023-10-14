import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:login/Api/ApiItem.dart';
import 'package:login/Model/Item.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int currentPage = 1;
  int lastPage = 1;
  List<Item> lists = [];
  final apiItem = ApiItem();
  HomeBloc() : super(HomeInitial()) {
    on<EHomeLogout>(logout);
    on<EHomeGetAll>(getAll);
    on<EHomeGetCountCart>(getCountCart);
    on<EHomeLoadMore>(loadmore);
    on<EHomeGetCountOrder>(getCountOrder);
  }

  FutureOr<void> logout(EHomeLogout event, Emitter<HomeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    if (!prefs.containsKey('token')) {
      emit(SHomeLogout(result: true));
    } else {
      emit(SHomeLogout(result: false));
    }
  }

  FutureOr<void> getAll(EHomeGetAll event, Emitter<HomeState> emit) async {
    emit(SHomeLoading());
    List<Item> listItem = await apiItem.getAllItem(currentPage);
    lists.addAll(listItem);
    emit(SHomeGetAll(lists: lists));
  }

  FutureOr<void> getCountCart(
      EHomeGetCountCart event, Emitter<HomeState> emit) async {
    int count = await apiItem.getCountCart(event.id);
    emit(SHomeGetCountCart(count: count));
  }

  FutureOr<void> loadmore(EHomeLoadMore event, Emitter<HomeState> emit) async {
    emit(SHomeLoadMoreLoading());
    currentPage++;
    List<Item> listItem = await apiItem.getAllItem(currentPage);
    if (listItem.isEmpty) {
      emit(SHomeLastPage());
    } else {
      lists.addAll(listItem);
      await Future.delayed(const Duration(seconds: 1));
      emit(SHomeGetAll(lists: lists));
    }
  }

  FutureOr<void> getCountOrder(
      EHomeGetCountOrder event, Emitter<HomeState> emit) async {
    int count = await apiItem.getCountOrder(event.id);
    emit(SHomeGetCountOrder(count: count));
  }
}
