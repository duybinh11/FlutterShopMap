import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/OrderDetail/bloc/order_bloc.dart';

class Pay extends StatefulWidget {
  const Pay({super.key});

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
  final List<String> _list = [
    'Thanh Toán sau khi nhận hàng',
    'MB Bank',
  ];
  String? pay = 'Thanh Toán sau khi nhận hàng';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Phương thức thanh toán',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        DropdownMenu<String>(
          menuHeight: 200,
          initialSelection: pay,
          dropdownMenuEntries:
              _list.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(
              value: value,
              label: value,
            );
          }).toList(),
          onSelected: (value) {
            setState(() {
              pay = value;
            });
            context.read<OrderBloc>().add(EOrderGetPay(pay: pay));
          },
        ),
      ],
    );
  }
}
