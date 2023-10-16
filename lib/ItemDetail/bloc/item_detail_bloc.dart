import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:login/Api/ApiItem.dart';
import 'package:login/ItemDetail/ui/ItemDetailPage.dart';
import 'package:meta/meta.dart';

import '../../Model/Item.dart';
import '../../Model/ShopModel.dart';

part 'item_detail_event.dart';
part 'item_detail_state.dart';

class ItemDetailBloc extends Bloc<ItemDetailEvent, ItemDetailState> {
  final apiItem = ApiItem();
  int count = 1;
  Item? itemDetail;
  ItemDetailBloc() : super(ItemDetailInitial()) {
    on<EItemDetailUpdate>(update);
    on<EItemDetailGetItem>(getItem);
    on<EItemDetailAddCart>(addCart);
    on<EItemDetailGetAll>(getAll);
    on<EItemDetailGetShop>(getShop);
  }

  FutureOr<void> update(
      EItemDetailUpdate event, Emitter<ItemDetailState> emit) {
    count = event.count;
  }

  FutureOr<void> getItem(
      EItemDetailGetItem event, Emitter<ItemDetailState> emit) async {
    emit(SItemDetailLoading());
    dynamic result = await apiItem.getItem(event.id);
    if (result is Item) {
      itemDetail = result;
      emit(SItemDetailGetItem(item: result));
    } else if (result is bool) {
      emit(SItemDetailErorr(erorr: result));
    }
  }

  FutureOr<void> addCart(
      EItemDetailAddCart event, Emitter<ItemDetailState> emit) async {
    emit(SItemDetailLoadingDialog());
    bool check = await apiItem.addCart(event.idUser, event.idItem, event.count);
    print(check);
    emit(SItemDetailAddCart(result: check));
  }

  FutureOr<void> getAll(
      EItemDetailGetAll event, Emitter<ItemDetailState> emit) async {
    List<Item> listItem = await apiItem.getAllItem(1);
    emit(SItemDetailGetAll(lists: listItem));
  }

  FutureOr<void> getShop(
      EItemDetailGetShop event, Emitter<ItemDetailState> emit) async {
    dynamic result = await apiItem.getShop(event.idItem);
    if (result is Shop) {
      emit(SItemDetailGetShop(shop: result));
    }
  }
}
