import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/ItemDetail/bloc/item_detail_bloc.dart';
import 'package:login/Login/bloc/login_bloc.dart';
import 'package:login/OrderDetail/ui/OrderDetaliPage.dart';

import '../../Home/bloc/home_bloc.dart';

class BottomItem extends StatelessWidget {
  const BottomItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(30, 50)),
            onPressed: () {
              if (context.read<LoginBloc>().acc != null &&
                  context.read<ItemDetailBloc>().itemDetail != null) {
                int idUser = context.read<LoginBloc>().acc!.id;
                int idItem = context.read<ItemDetailBloc>().itemDetail!.id;
                int count = context.read<ItemDetailBloc>().count;

                context.read<ItemDetailBloc>().add(EItemDetailAddCart(
                    count: count, idUser: idUser, idItem: idItem));
              }
            },
            label: const Text(
              'Giỏ Hàng',
              style: TextStyle(color: Colors.white),
            ),
            icon: const Icon(
              Icons.card_travel,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(30, 50)),
                onPressed: () {
                  if (context.read<LoginBloc>().acc != null &&
                      context.read<ItemDetailBloc>().itemDetail != null) {
                    int idUser = context.read<LoginBloc>().acc!.id;
                    int idItem = context.read<ItemDetailBloc>().itemDetail!.id;
                    int count = context.read<ItemDetailBloc>().count;
                    Map<String, dynamic> params = {
                      'idUser': idUser,
                      'idItem': idItem,
                      'count': count,
                    };
                    Navigator.pushNamed(context, OrderDetailPage.routeName,
                        arguments: params);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                      child: Image.network(
                          'https://cdn-icons-png.flaticon.com/128/9752/9752284.png'),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    const Text(
                      'Mua Hàng',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
