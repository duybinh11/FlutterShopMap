import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/Cart/ui/CartPage.dart';
import 'package:login/OrderList/ui/OrderMainPage.dart';

import '../bloc/home_bloc.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      stretch: true,
      floating: true,
      title: const Text('Home'),
      actions: [
        BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) {
            if (current is SHomeGetCountCart) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            if (state is SHomeGetCountCart) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, CartPage.nameRoute);
                },
                child: Badge(
                  label: Text('${state.count}'),
                  child: SizedBox(
                    height: 30,
                    child: Image.network(
                        'https://cdn-icons-png.flaticon.com/128/726/726496.png'),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
        const SizedBox(
          width: 15,
        ),
        BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) {
            if (current is SHomeGetCountOrder) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            if (state is SHomeGetCountOrder) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, OrderMainPage.nameRoute);
                },
                child: Badge(
                  label: Text('${state.count}'),
                  child: SizedBox(
                    height: 30,
                    child: Image.network(
                        'https://cdn-icons-png.flaticon.com/128/3684/3684620.png'),
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
