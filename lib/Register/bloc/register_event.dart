// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class ERegisterCreate extends RegisterEvent {
  String email;
  String username;
  String pass;
  ERegisterCreate({
    required this.email,
    required this.username,
    required this.pass,
  });
}
