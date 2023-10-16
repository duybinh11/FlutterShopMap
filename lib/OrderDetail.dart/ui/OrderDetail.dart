import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/Login/bloc/login_bloc.dart';
import 'package:login/Model/Order.dart';
import 'package:login/Model/User1.dart';
import 'package:login/Model/VnpayModel.dart';
import 'package:login/OrderDetail.dart/bloc/order_detail_bloc.dart';
import 'package:login/OrderList/bloc/order_list_bloc.dart';

import '../../Model/Item.dart';
import 'InforBanking.dart';
import 'InforBill.dart';
import 'InforPay.dart';
import 'InforUser.dart';

class OrderDetailList extends StatefulWidget {
  static const String routeName = '/OrderDetail';
  const OrderDetailList({super.key});

  @override
  State<OrderDetailList> createState() => _OrderDetailListState();
}

class _OrderDetailListState extends State<OrderDetailList> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)!.settings.arguments as OrderModel;
    if (order.bill.pay == 'MB Bank') {
      context
          .read<OrderDetailBloc>()
          .add(EOrderGetVnpay(idBill: order.bill.id));
    } else {
      context.read<OrderDetailBloc>().add(EOrderClearState());
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(order.item.name),
      ),
      body: BlocConsumer<OrderDetailBloc, OrderDetailState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is SOrderDetailLoaing) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SOrderDetailVnpay) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: BodyOrderDetail(orderModel: order, vnpay: state.vnpay),
                )
              ],
            );
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: BodyOrderDetail(orderModel: order),
              )
            ],
          );
        },
      ),
    );
  }
}

class BodyOrderDetail extends StatelessWidget {
  OrderModel orderModel;
  VnpayModel? vnpay;
  BodyOrderDetail({super.key, required this.orderModel, this.vnpay});
  TextStyle titles = const TextStyle(fontSize: 16, fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    User1 user = context.read<LoginBloc>().acc!;
    Item item = orderModel.item;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 230,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(
                    image: NetworkImage(orderModel.item.img),
                    fit: BoxFit.cover)),
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
          const Text('Thông Tin Người Nhận',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
          const SizedBox(
            height: 5,
          ),
          inforUser(titles: titles, user: user),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
          const Text('Thông Tin Đơn Hàng',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
          const SizedBox(
            height: 5,
          ),
          InforBill(titles: titles, item: item, orderModel: orderModel),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
          const Text('Thông Tin Thanh Toán',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
          const SizedBox(
            height: 5,
          ),
          InforPay(titles: titles, orderModel: orderModel),
          vnpay != null
              ? InforBanking(titles: titles, vnpay: vnpay)
              : const SizedBox(),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
