import 'package:flutter/material.dart';
import 'package:login/OrderDetail/ui/pay.dart';

import '../../Model/Item.dart';
import 'InforUser.dart';
import 'OrderBill.dart';

// ignore: must_be_immutable
class BodyOrder extends StatelessWidget {
  const BodyOrder({
    super.key,
    required this.item,
  });
  final Item? item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(7)),
                image: DecorationImage(
                    image: NetworkImage(
                      item!.img,
                    ),
                    fit: BoxFit.cover)),
            height: 200,
            width: double.infinity,
          ),
          const SizedBox(
            height: 10,
          ),
          OrderBill(),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
          const InforUser(),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
          const Pay()
        ],
      ),
    );
  }
}
