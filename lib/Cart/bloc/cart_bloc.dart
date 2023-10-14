import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:login/Api/ApiItem.dart';
import 'package:login/Model/CartModel.dart';


part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final apiItem = ApiItem();
  CartBloc() : super(CartInitial()) {
    on<ECartGetAll>(getAllCart);
    on<ECartDelete>(deleteCart);
  }

  FutureOr<void> getAllCart(ECartGetAll event, Emitter<CartState> emit) async {
    emit(SCartLoading());

    List<CartModel> lists = await apiItem.getCartAll(event.id);

    emit(SCartGetAll(list: lists));
  }

  FutureOr<void> deleteCart(ECartDelete event, Emitter<CartState> emit) async {
    emit(SCartLoading());
    bool check = await apiItem.deleteCart(event.id);
    emit(SCartDelete(check: check));
  }
}
