import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:login/Api/ApiItem.dart';
import 'package:meta/meta.dart';

part 'banking_event.dart';
part 'banking_state.dart';

class BankingBloc extends Bloc<BankingEvent, BankingState> {
  int idOder = 0;
  bool isSuccess = false;
  String status = '';
  final api = ApiItem();
  BankingBloc() : super(BankingInitial()) {
    on<EbankingUrl>(getUrl);
    on<EBankStatus>(changestatus);
    on<EBankingVnpay>(vnpay);
  }
  FutureOr<void> getUrl(EbankingUrl event, Emitter<BankingState> emit) async {
    emit(SBankingLoading());
    String url = await api.geturl();
    emit(SBankingUrl(url: url));
  }

  FutureOr<void> changestatus(
      EBankStatus event, Emitter<BankingState> emit) async {
    emit(SBankingLoading());
    isSuccess = event.isSuccess;
    status = event.status;
    await Future.delayed(const Duration(seconds: 1));
    emit(SBankingResult(isSuccess: isSuccess, status: status));
  }

  FutureOr<void> vnpay(EBankingVnpay event, Emitter<BankingState> emit) {
    api.createVnpay(
        event.idBill, event.amount, event.bankCode, event.payStatus);
  }
}
