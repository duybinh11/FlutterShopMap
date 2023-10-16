import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Model/Order.dart';

class InforPay extends StatelessWidget {
  const InforPay({
    super.key,
    required this.titles,
    required this.orderModel,
  });

  final TextStyle titles;
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
            'Id',
            style: titles,
          )),
          DataColumn(
              label: Text(
            'PTTT',
            style: titles,
          )),
          DataColumn(
            label: Text(
              'State',
              style: titles,
            ),
          ),
          DataColumn(
              label: Text(
            'ngày',
            style: titles,
          )),
        ],
        rows: [
          DataRow(cells: [
            DataCell(
              Text(
                '${orderModel.bill.id}',
                style: const TextStyle(fontSize: 17),
              ),
            ),
            DataCell(
              Text(
                '${orderModel.bill.pay}',
                style: const TextStyle(fontSize: 17),
              ),
            ),
            DataCell(
              Text(
                orderModel.bill.statusPay.toString(),
                style: const TextStyle(fontSize: 17),
              ),
            ),
            DataCell(
              Text(
                '${orderModel.bill.ngayPay}',
                style: const TextStyle(fontSize: 17),
              ),
            )
          ])
        ],
      ),
    );
  }
}
