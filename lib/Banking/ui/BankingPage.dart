import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/Banking/Bank/bloc/banking_bloc.dart';
import 'package:login/ItemDetail/bloc/item_detail_bloc.dart';

import 'package:login/OrderDetail/bloc/order_bloc.dart';
import 'package:vnpay_flutter/vnpay_flutter.dart';

import '../../Login/bloc/login_bloc.dart';
import '../../Model/Item.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

class MbPage extends StatefulWidget {
  static const String nameRoute = '/MbPage';
  const MbPage({super.key});

  @override
  State<MbPage> createState() => _MbPageState();
}

class _MbPageState extends State<MbPage> {
  bool success = false;
  String status = '';
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    context.read<BankingBloc>().add(EBankStatus(isSuccess: false, status: ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán trực tuyến'),
      ),
      body: BlocConsumer<BankingBloc, BankingState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is SBankingLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SBankingUrl) {
            VNPAYFlutter.instance.show(
              paymentUrl: state.url,
              onPaymentSuccess: (map) {
                if (map['vnp_TransactionStatus'] == '00') {
                  status = 'thanh cong';
                  int idBill = context.read<OrderBloc>().idBill!;
                  int? amount = int.tryParse(map['vnp_Amount']);
                  String bankCode = map['vnp_BankCode'] as String;
                  context.read<BankingBloc>().add(EBankingVnpay(
                      idBill: idBill,
                      amount: amount!,
                      bankCode: bankCode,
                      payStatus: true));
                }

                context
                    .read<BankingBloc>()
                    .add(EBankStatus(isSuccess: true, status: status));
              },
              onPaymentError: (params) {
                status = 'chua thanh toan';
                context
                    .read<BankingBloc>()
                    .add(EBankStatus(isSuccess: true, status: status));
              },
            );
          }
          if (state is SBankingResult) {
            return state.isSuccess
                ? Center(
                    child: Image.network(
                        'https://cdn-icons-png.flaticon.com/128/677/677069.png'),
                  )
                : Center(
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            int idUser = context.read<LoginBloc>().acc!.id;
                            Item item =
                                context.read<ItemDetailBloc>().itemDetail!;
                            int count = context.read<ItemDetailBloc>().count;
                            String pay = context.read<OrderBloc>().pay!;
                            context.read<OrderBloc>().add(EOrderBuy(
                                idUser: idUser,
                                idItem: item.id,
                                sl: count,
                                pay: pay));
                            context.read<BankingBloc>().add(EbankingUrl());
                          },
                          child: const Center(child: Text('thanh toan'))),
                    ),
                  );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

Future<String> geturl() async {
  Uri uri = Uri.parse('http://10.0.2.2:8000/api/vnpay');
  http.Response response = await http.post(uri);

  if (response.statusCode == 200) {
    Map<String, dynamic> map = jsonDecode(response.body);
    return map['data'];
  }
  return 'dd';
}
