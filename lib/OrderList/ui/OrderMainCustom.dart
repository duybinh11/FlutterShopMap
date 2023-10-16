import 'package:flutter/material.dart';
import 'package:login/OrderDetail/ui/OrderDetaliPage.dart';

import '../../Model/Order.dart';

class OrderMainCustom extends StatelessWidget {
  OrderMainCustom({
    super.key,
    required this.order,
  });

  OrderModel order;

  @override
  Widget build(BuildContext context) {
    final item = order.item;
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      margin: const EdgeInsets.only(right: 5, left: 5, bottom: 5),
      width: double.infinity,
      height: 130,
      child: Row(children: [
        const SizedBox(
          width: 5,
        ),
        Container(
          width: 150,
          height: 120,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              image: DecorationImage(
                  image: NetworkImage(
                    item.img,
                  ),
                  fit: BoxFit.cover)),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    item.name,
                    style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: Colors.amber),
                  ),
                ),
              ),
              Text(
                'Giá : ${item.cost}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(order.bill.statusPay ? 'Đã thanh toán' : 'Chưa thanh toán',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500)),
              Text('Tiền : ${item.cost * order.sl}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        )
      ]),
    );
  }
}
