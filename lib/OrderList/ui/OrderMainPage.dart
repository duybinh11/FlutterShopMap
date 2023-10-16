import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:login/Login/bloc/login_bloc.dart';
import 'package:login/Model/Order.dart';
import 'package:login/OrderDetail.dart/ui/OrderDetail.dart';
import 'package:login/OrderList/bloc/order_list_bloc.dart';

import 'OrderMainCustom.dart';

class OrderMainPage extends StatefulWidget {
  static const String nameRoute = '/OrderMainPage';
  const OrderMainPage({super.key});

  @override
  State<OrderMainPage> createState() => _OrderMainPageState();
}

class _OrderMainPageState extends State<OrderMainPage> {
  @override
  void initState() {
    int id = context.read<LoginBloc>().acc!.id;
    context.read<OrderListBloc>().add(EOrderListGetAllOrder(id: id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đơn Hàng'),
      ),
      body: BlocBuilder<OrderListBloc, OrderListState>(
        builder: (context, state) {
          if (state is SOrderListLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SOrderListGetAll) {
            final list = state.list;
            if (list.isEmpty) {
              return const Text('don hang rong');
            }
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, OrderDetailList.routeName,
                        arguments: list[index]);
                  },
                  child: OrderMainCustom(order: list[index])),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
