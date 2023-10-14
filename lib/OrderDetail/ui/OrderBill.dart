import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/ItemDetail/bloc/item_detail_bloc.dart';

import '../../Model/Item.dart';
import '../../Model/User1.dart';

class OrderBill extends StatefulWidget {
  OrderBill({
    super.key,
  });

  @override
  State<OrderBill> createState() => _OrderBillState();
}

class _OrderBillState extends State<OrderBill> {
  Item? item;
  @override
  void initState() {
    item = context.read<ItemDetailBloc>().itemDetail!;
    super.initState();
  }

  TextStyle titles = const TextStyle(fontSize: 16, fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hóa Đơn',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: double.infinity,
          child: DataTable(
            columnSpacing: 25,
            border: const TableBorder(
                top: BorderSide(),
                right: BorderSide(),
                left: BorderSide(),
                bottom: BorderSide(),
                verticalInside: BorderSide(),
                horizontalInside: BorderSide()),
            columns: [
              DataColumn(
                  label: Text(
                'Tên',
                style: titles,
              )),
              DataColumn(
                  label: Text(
                'Giá(vnd)',
                style: titles,
              )),
              DataColumn(
                label: Text(
                  'SL',
                  style: titles,
                ),
              ),
              DataColumn(
                  label: Text(
                'Tiền(vnd)',
                style: titles,
              )),
            ],
            rows: [
              DataRow(cells: [
                DataCell(
                  Text(
                    item!.name,
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
                DataCell(
                  Text(
                    '${item!.cost}',
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
                DataCell(
                  Text(
                    '${context.read<ItemDetailBloc>().count}',
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
                DataCell(
                  Text(
                    '${item!.cost * context.read<ItemDetailBloc>().count}',
                    style: const TextStyle(fontSize: 17),
                  ),
                )
              ])
            ],
          ),
        ),
      ],
    );
  }
}
