import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/Banking/Bank/bloc/banking_bloc.dart';
import 'package:login/ItemDetail/bloc/item_detail_bloc.dart';

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
  @override
  void initState() {
    context.read<BankingBloc>().add(EBankStatus(
          isSuccess: false,
        ));
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
                  int idBill = context.read<OrderBloc>().idBill!;
                  int? amount = int.tryParse(map['vnp_Amount']);
                  String bankCode = map['vnp_BankCode'] as String;
                  context.read<BankingBloc>().add(EBankingVnpay(
                      idBill: idBill,
                      amount: amount!,
                      bankCode: bankCode,
                      payStatus: true));
                  context.read<BankingBloc>().add(EBankingIsPay(isPay: true));
                }
                context.read<BankingBloc>().add(EBankStatus(
                      isSuccess: true,
                    ));
              },
              onPaymentError: (params) {
                print('chua thanh toan');
                int idBill = context.read<OrderBloc>().idBill!;
                context
                    .read<BankingBloc>()
                    .add(EBankingVnpay(idBill: idBill, payStatus: false));
                context.read<BankingBloc>().add(EBankStatus(isSuccess: false));
                context.read<BankingBloc>().add(EBankStatus(
                      isSuccess: true,
                    ));
              },
            );
          }
          if (state is SBankingResult) {
            return state.isSuccess
                ? Center(
                    child: Image.network(state.isPay
                        ? 'https://cdn-icons-png.flaticon.com/128/677/677069.png'
                        : 'https://cdn-icons-png.flaticon.com/128/2797/2797387.png'),
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
                            context
                                .read<BankingBloc>()
                                .add(EbankingUrl(cost: count * item.cost));
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
