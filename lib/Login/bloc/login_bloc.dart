import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:login/Api/Auth.dart';
import 'package:login/Model/User1.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  User1? acc;
  final apiAuth = AuthApi();
  LoginBloc() : super(LoginInitial()) {
    on<ELoginLogin>(login);
    on<ELoginToken>(checkToken);
  }

  FutureOr<void> login(ELoginLogin event, Emitter<LoginState> emit) async {
    emit(SLoginLoading());
    dynamic resullt = await apiAuth.login(event.email, event.pass);

    if (resullt is User1) {
      acc = resullt;
      emit(SLoginResult(user: resullt));
    }
    if (resullt is bool) {
      emit(SloginErorr(result: resullt));
    }
  }

  FutureOr<void> checkToken(ELoginToken event, Emitter<LoginState> emit) async {
    emit(SLoginLoading());
    dynamic result = await apiAuth.checkToken();
    if (result is User1) {
      acc = result;
      emit(SLoginToken(result: true));
    }
    if (result is bool) {
      emit(SLoginToken(result: false));
    }
  }
}
