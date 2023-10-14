import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:login/Api/ApiItem.dart';
import 'package:login/Model/Order.dart';
import 'package:meta/meta.dart';

part 'order_list_event.dart';
part 'order_list_state.dart';

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {
  final api = ApiItem();
  OrderListBloc() : super(OrderListInitial()) {
    on<EOrderListGetAllOrder>(getAllOrder);
  }

  FutureOr<void> getAllOrder(
      EOrderListGetAllOrder event, Emitter<OrderListState> emit) async {
    emit(SOrderListLoading());
    List<OrderModel> list = await api.getAllOrder(event.id);
    emit(SOrderListGetAll(list: list));
  }
}
