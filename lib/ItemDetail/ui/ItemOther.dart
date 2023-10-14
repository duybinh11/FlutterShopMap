import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/ItemDetail/bloc/item_detail_bloc.dart';

import '../../Home/bloc/home_bloc.dart';
import '../../Home/ui/Customitem.dart';

class ItemOhter extends StatelessWidget {
  const ItemOhter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemDetailBloc, ItemDetailState>(
      buildWhen: (previous, current) {
        if (current is SItemDetailGetAll) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is SItemDetailGetAll) {
          return SliverGrid.builder(
              itemCount: state.lists.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.75,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CustomItem(item: state.lists[index]),
                  ));
        }
        return const SliverToBoxAdapter(
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
