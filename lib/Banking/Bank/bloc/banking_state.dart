// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'banking_bloc.dart';

@immutable
sealed class BankingState {}

final class BankingInitial extends BankingState {}

final class SBankingLoading extends BankingState {}

class SBankingUrl extends BankingState {
  String url;
  SBankingUrl({
    required this.url,
  });
}

class SBankingResult extends BankingState {
  bool isSuccess;
  String status;
  SBankingResult({
    required this.isSuccess,
    required this.status,
  });
}
