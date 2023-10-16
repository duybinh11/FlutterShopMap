import 'package:flutter/material.dart';

import '../../Model/Item.dart';
import '../../Model/Order.dart';

class InforBill extends StatelessWidget {
  const InforBill({
    super.key,
    required this.titles,
    required this.item,
    required this.orderModel,
  });

  final TextStyle titles;
  final Item item;
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                item.name,
                style: const TextStyle(fontSize: 17),
              ),
            ),
            DataCell(
              Text(
                '${item.cost}',
                style: const TextStyle(fontSize: 17),
              ),
            ),
            DataCell(
              Text(
                '${orderModel.sl}',
                style: const TextStyle(fontSize: 17),
              ),
            ),
            DataCell(
              Text(
                '${item.cost * orderModel.sl}',
                style: const TextStyle(fontSize: 17),
              ),
            )
          ])
        ],
      ),
    );
  }
}
