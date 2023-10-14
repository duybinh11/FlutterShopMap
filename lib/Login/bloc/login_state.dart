// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class SLoginLoading extends LoginState {}

class SLoginResult extends LoginState {
  User1 user;
  SLoginResult({
    required this.user,
  });
}

class SloginErorr extends LoginState {
  bool result;
  SloginErorr({
    required this.result,
  });
}

class SLoginToken extends LoginState {
  bool result;
  SLoginToken({
    required this.result,
  });
}
