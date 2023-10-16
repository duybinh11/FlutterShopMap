import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:login/Api/ApiItem.dart';
import 'package:login/Model/VnpayModel.dart';
import 'package:meta/meta.dart';

part 'order_detail_event.dart';
part 'order_detail_state.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  final api = ApiItem();
  OrderDetailBloc() : super(OrderDetailInitial()) {
    on<EOrderGetVnpay>(getVnpay);
    on<EOrderClearState>(clearState);
  }

  FutureOr<void> getVnpay(
      EOrderGetVnpay event, Emitter<OrderDetailState> emit) async {
    emit(SOrderDetailLoaing());
    dynamic result = await api.getVnpay(event.idBill);
    if (result is VnpayModel) {
      emit(SOrderDetailVnpay(vnpay: result));
    } else {
      // emit()
    }
  }

  FutureOr<void> clearState(
      EOrderClearState event, Emitter<OrderDetailState> emit) {
    emit(SOrderClear());
  }
}
