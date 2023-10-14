import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/Cart/bloc/cart_bloc.dart';
import 'package:login/Model/CartModel.dart';

import '../../Model/Item.dart';

// ignore: must_be_immutable
class CartCustom extends StatelessWidget {
  CartModel cartModel;

  CartCustom({
    Key? key,
    required this.cartModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Item item = cartModel.item;
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
        leading: ClipOval(
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30,
            child: Image.network(item.img, fit: BoxFit.cover),
          ),
        ),
        title: Text(
          item.name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        subtitle: Text('${cartModel.ngay} VND'),
        tileColor: Colors.grey.withOpacity(0.2),
        trailing: IconButton(
            onPressed: () {
              context.read<CartBloc>().add(ECartDelete(id: cartModel.id));
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.black,
            )),
      ),
    );
  }
}
