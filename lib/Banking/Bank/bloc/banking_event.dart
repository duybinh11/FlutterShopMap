// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'banking_bloc.dart';

@immutable
sealed class BankingEvent {}

// ignore: must_be_immutable
class EbankingUrl extends BankingEvent {
  int cost;
  EbankingUrl({
    required this.cost,
  });
}

class EBankStatus extends BankingEvent {
  bool isSuccess;
  EBankStatus({
    required this.isSuccess,
  });
}

class EBankingVnpay extends BankingEvent {
  int idBill;
  int? amount;
  String? bankCode;
  bool payStatus;
  EBankingVnpay(
      {required this.idBill,
      this.amount,
      this.bankCode,
      required this.payStatus});
}

class EBankingBill extends BankingEvent {
  String pay;
  String status;
  int ngay;
  EBankingBill({
    required this.pay,
    required this.status,
    required this.ngay,
  });
}

class EBankingIsPay extends BankingEvent {
  bool isPay;
  EBankingIsPay({
    required this.isPay,
  });
}

class EBankingOrder extends BankingEvent {
  int idUser;
  int idItem;
  int sl;
  String? pay;
  EBankingOrder({
    required this.idUser,
    required this.idItem,
    required this.sl,
    required this.pay,
  });
}
