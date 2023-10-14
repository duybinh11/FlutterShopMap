// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'item_detail_bloc.dart';

@immutable
sealed class ItemDetailEvent {}

class EItemDetailUpdate extends ItemDetailEvent {
  int count;
  EItemDetailUpdate({
    required this.count,
  });
}

class EItemDetailGetItem extends ItemDetailEvent {
  int id;
  EItemDetailGetItem({
    required this.id,
  });
}

class EItemDetailGetAll extends ItemDetailEvent {}

class EItemDetailAddCart extends ItemDetailEvent {
  int count;
  int idUser;
  int idItem;
  EItemDetailAddCart({
    required this.count,
    required this.idUser,
    required this.idItem,
  });
}
