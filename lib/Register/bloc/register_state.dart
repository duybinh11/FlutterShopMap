// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class SRegisterLoading extends RegisterState {}

class SRegisterResult extends RegisterState {
  bool result;
  SRegisterResult({
    required this.result,
  });
}
