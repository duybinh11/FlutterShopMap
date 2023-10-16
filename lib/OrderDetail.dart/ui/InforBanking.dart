import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Model/VnpayModel.dart';

class InforBanking extends StatelessWidget {
  const InforBanking({
    super.key,
    required this.titles,
    required this.vnpay,
  });

  final TextStyle titles;
  final VnpayModel? vnpay;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 5,
        ),
        const Divider(),
        const Text('Thông Tin Banking',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: double.infinity,
          child: DataTable(
            columnSpacing: 12,
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
                'Money',
                style: titles,
              )),
              DataColumn(
                label: Text(
                  'Code',
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
                    '${vnpay!.id}',
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
                DataCell(
                  Text(
                    '${vnpay!.cost}',
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
                DataCell(
                  Text(
                    vnpay!.bankCode.toString(),
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
                DataCell(
                  Text(
                    vnpay!.ngay,
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
