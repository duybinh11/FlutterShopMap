import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:login/Api/ApiItem.dart';
import 'package:meta/meta.dart';

part 'banking_event.dart';
part 'banking_state.dart';

class BankingBloc extends Bloc<BankingEvent, BankingState> {
  int idOder = 0;
  bool isSuccess = false;
  bool isPay = false;
  final api = ApiItem();
  BankingBloc() : super(BankingInitial()) {
    on<EbankingUrl>(getUrl);
    on<EBankStatus>(changestatus);
    on<EBankingVnpay>(vnpay);
    on<EBankingIsPay>(isPayF);
  }
  FutureOr<void> getUrl(EbankingUrl event, Emitter<BankingState> emit) async {
    emit(SBankingLoading());
    String url = await api.geturl(event.cost);
    print(url);
    emit(SBankingUrl(url: url));
  }

  FutureOr<void> changestatus(
      EBankStatus event, Emitter<BankingState> emit) async {
    emit(SBankingLoading());
    isSuccess = event.isSuccess;

    await Future.delayed(const Duration(seconds: 1));
    emit(SBankingResult(isSuccess: isSuccess, isPay: isPay));
  }

  FutureOr<void> vnpay(EBankingVnpay event, Emitter<BankingState> emit) {
    api.createVnpay(
        event.idBill, event.amount, event.bankCode, event.payStatus);
  }

  FutureOr<void> isPayF(EBankingIsPay event, Emitter<BankingState> emit) {
    isPay = event.isPay;
  }
}
