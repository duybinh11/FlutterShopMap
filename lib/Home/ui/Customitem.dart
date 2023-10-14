import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/ItemDetail/bloc/item_detail_bloc.dart';
import 'package:login/ItemDetail/ui/ItemDetailPage.dart';

import '../../Model/Item.dart';

class CustomItem extends StatelessWidget {
  Item item;
  CustomItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ItemDetailPage.nameRoute,
        );
        context.read<ItemDetailBloc>().add(EItemDetailGetItem(id: item.id));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Colors.grey.withOpacity(0.15),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                      image: DecorationImage(
                          image: NetworkImage(item.img), fit: BoxFit.cover))),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Column(
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${item.cost} VND',
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                      const Text('4.9 '),
                      SizedBox(
                        height: 18,
                        width: 18,
                        child: Image.network(
                            'https://cdn-icons-png.flaticon.com/128/616/616489.png'),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
