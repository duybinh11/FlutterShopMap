// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'item_detail_bloc.dart';

@immutable
sealed class ItemDetailState {}

final class ItemDetailInitial extends ItemDetailState {}

final class SItemDetailLoading extends ItemDetailState {}

final class SItemDetailLoadingDialog extends ItemDetailState {}

class SItemDetailGetItem extends ItemDetailState {
  Item item;
  SItemDetailGetItem({
    required this.item,
  });
}

class SItemDetailGetAll extends ItemDetailState {
  List<Item> lists;
  SItemDetailGetAll({
    required this.lists,
  });
}

class SItemDetailErorr extends ItemDetailState {
  bool erorr;
  SItemDetailErorr({
    required this.erorr,
  });
}

class SItemDetailAddCart extends ItemDetailState {
  bool result;
  SItemDetailAddCart({
    required this.result,
  });
}

class SItemDetailGetShop extends ItemDetailState {
  Shop shop;
  SItemDetailGetShop({
    required this.shop,
  });
}
