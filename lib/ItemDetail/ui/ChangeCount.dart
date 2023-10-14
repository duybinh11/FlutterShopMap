import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/ItemDetail/bloc/item_detail_bloc.dart';

class ChangeCount extends StatefulWidget {
  const ChangeCount({super.key});

  @override
  State<ChangeCount> createState() => _ChangeCountState();
}

class _ChangeCountState extends State<ChangeCount> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (count > 1) {
              setState(() {
                count--;
                context
                    .read<ItemDetailBloc>()
                    .add(EItemDetailUpdate(count: count));
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(width: 1)),
            height: 35,
            width: 35,
            child: Image.network(
                'https://cdn-icons-png.flaticon.com/128/2801/2801932.png'),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(width: 1)),
          height: 35,
          width: 35,
          child: Text(
            '$count',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              count++;
              context
                  .read<ItemDetailBloc>()
                  .add(EItemDetailUpdate(count: count));
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(width: 1)),
            height: 35,
            width: 35,
            child: Image.network(
                'https://cdn-icons-png.flaticon.com/128/1828/1828925.png'),
          ),
        ),
      ],
    );
  }
}
