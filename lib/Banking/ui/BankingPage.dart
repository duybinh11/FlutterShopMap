import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/Banking/Bank/bloc/banking_bloc.dart';
import 'package:login/ItemDetail/bloc/item_detail_bloc.dart';
import 'package:login/Model/Order.dart';
import 'package:login/OrderDetail/bloc/order_bloc.dart';
import 'package:vnpay_flutter/vnpay_flutter.dart';

import '../../Login/bloc/login_bloc.dart';
import '../../Model/Item.dart';

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
    print('build');
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
                }
                if (map['vnp_TransactionStatus'] == '24') {
                  status = 'chua thanh toan';
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
            print(state.status);
            return state.isSuccess
                ? Text(status)
                : Center(
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
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
