import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Login/bloc/login_bloc.dart';
import '../../Model/User1.dart';

class InforUser extends StatefulWidget {
  const InforUser({
    super.key,
  });

  @override
  State<InforUser> createState() => _InforUserState();
}

class _InforUserState extends State<InforUser> {
  User1? user;
  @override
  void initState() {
    user = context.read<LoginBloc>().acc!;
    super.initState();
  }

  TextStyle titles = const TextStyle(fontSize: 16, fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Thông Tin Người Nhận',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: double.infinity,
          child: DataTable(border: TableBorder.all(width: 1), columns: [
            DataColumn(
              label: Text('Tên', style: titles),
            ),
            DataColumn(
              label: Text('Địa Chỉ', style: titles),
            ),
            DataColumn(
              label: Text('SDT', style: titles),
            )
          ], rows: [
            DataRow(cells: [
              DataCell(
                  Text(user!.username, style: const TextStyle(fontSize: 17))),
              DataCell(
                  Text(user!.address, style: const TextStyle(fontSize: 17))),
              DataCell(Text(user!.phone, style: const TextStyle(fontSize: 17)))
            ])
          ]),
        ),
      ],
    );
  }
}
