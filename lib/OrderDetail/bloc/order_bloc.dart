import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:login/Api/ApiItem.dart';
import 'package:login/Model/Item.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final apiItem = ApiItem();
  int? idBill;
  String? pay = 'Thanh Toán sau khi nhận hàng';
  OrderBloc() : super(OrderInitial()) {
    on<EOrderGetPay>(getPay);
    on<EOrderBuy>(buyItem);
  }

  FutureOr<void> getPay(EOrderGetPay event, Emitter<OrderState> emit) {
    pay = event.pay;
  }

  FutureOr<void> buyItem(EOrderBuy event, Emitter<OrderState> emit) async {
    emit(SOrderLoading());
    dynamic check =
        await apiItem.buyItem(event.idUser, event.idItem, event.sl, event.pay);
    if (check is int) {
      idBill = check;
      emit(SOrderBuyItem(check: true));
    } else {
      emit(SOrderBuyItem(check: false));
    }
  }
}
