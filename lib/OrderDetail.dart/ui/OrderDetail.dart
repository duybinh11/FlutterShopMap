import 'package:flutter/material.dart';
import 'package:login/Model/Order.dart';

class OrderDetailList extends StatelessWidget {
  static const String routeName = '/OrderDetail';
  const OrderDetailList({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as OrderModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(arguments.item.name),
      ),
    );
  }
}
