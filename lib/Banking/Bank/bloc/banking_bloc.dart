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
    await Future.delayed(Duration(seconds: 1));
    emit(SBankingResult(isSuccess: isSuccess, status: status));
  }
}
