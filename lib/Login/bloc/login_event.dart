// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class ELoginLogin extends LoginEvent {
  String email;
  String pass;
  ELoginLogin({
    required this.email,
    required this.pass,
  });
}

class ELoginToken extends LoginEvent {}
