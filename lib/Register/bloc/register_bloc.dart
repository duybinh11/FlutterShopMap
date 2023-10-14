import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:login/Api/Auth.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final apiAuth = new AuthApi();
  RegisterBloc() : super(RegisterInitial()) {
    on<ERegisterCreate>(register);
  }

  FutureOr<void> register(
      ERegisterCreate event, Emitter<RegisterState> emit) async {
    emit(SRegisterLoading());
    bool result =
        await apiAuth.register(event.email, event.username, event.pass);
    emit(SRegisterResult(result: result));
  }
}
