import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Model/User1.dart';

class inforUser extends StatelessWidget {
  const inforUser({
    super.key,
    required this.titles,
    required this.user,
  });

  final TextStyle titles;
  final User1 user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
          border: TableBorder.all(width: 1),
          dataRowMaxHeight: 50,
          columnSpacing: 10,
          columns: [
            DataColumn(
              label: Text('Tên', style: titles),
            ),
            DataColumn(
              label: Text('Địa Chỉ', style: titles),
            ),
            DataColumn(
              label: Text('SDT', style: titles),
            )
          ],
          rows: [
            DataRow(cells: [
              DataCell(
                  Text(user.username, style: const TextStyle(fontSize: 17))),
              DataCell(
                  Text(user.address, style: const TextStyle(fontSize: 17))),
              DataCell(Text(user.phone, style: const TextStyle(fontSize: 17)))
            ])
          ]),
    );
  }
}
