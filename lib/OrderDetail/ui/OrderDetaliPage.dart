import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/Cart/bloc/cart_bloc.dart';
import 'package:login/Home/bloc/home_bloc.dart';
import 'package:login/ItemDetail/bloc/item_detail_bloc.dart';
import 'package:login/Login/bloc/login_bloc.dart';
import 'package:login/Banking/ui/BankingPage.dart';

import 'package:login/Model/User1.dart';
import 'package:login/OrderDetail/bloc/order_bloc.dart';
import 'package:login/main.dart';

import '../../Model/Item.dart';

import 'OrderBody.dart';

class OrderDetailPage extends StatefulWidget {
  static const String routeName = '/OrderDetailPage';
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  User1? user;
  Item? item;
  @override
  void initState() {
    user = context.read<LoginBloc>().acc!;
    item = context.read<ItemDetailBloc>().itemDetail!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item!.name),
      ),
      body: BlocListener<OrderBloc, OrderState>(
        listenWhen: (previous, current) {
          if (current is SOrderBuyItem) {
            return true;
          }
          return false;
        },
        listener: (context, state) {
          if (state is SOrderBuyItem) {
            String x = 'Mua hàng thất bại';
            if (state.check) {
              x = 'Mua hàng thành công';
              int id = context.read<LoginBloc>().acc!.id;
              context.read<HomeBloc>().add(EHomeGetCountOrder(id: id));
            }
            showDialog(
              context: context,
              builder: (context) => showdialogcustom('Đơn Hàng', x, context),
            );
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [BodyOrder(item: item)],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.grey.withOpacity(0.2),
        child: ElevatedButton(
            onPressed: () {
              int idUser = context.read<LoginBloc>().acc!.id;
              int idItem = context.read<ItemDetailBloc>().itemDetail!.id;
              int sl = context.read<ItemDetailBloc>().count;
              String? pay = context.read<OrderBloc>().pay;
              if (pay == 'MB Bank') {
                Navigator.pushNamed(context, MbPage.nameRoute);
              } else {
                context.read<OrderBloc>().add(EOrderBuy(
                    idUser: idUser, idItem: idItem, sl: sl, pay: pay));
              }
            },
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(),
                minimumSize: const Size(double.infinity, 50)),
            child: const Text(
              'Mua',
              style: TextStyle(color: Colors.white, fontSize: 18),
            )),
      ),
    );
  }
}
