import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ItemDetail/ui/ItemDetailPage.dart';
import '../bloc/home_bloc.dart';
import 'Customitem.dart';

class BodyHome extends StatelessWidget {
  ScrollController sc;
  BodyHome({super.key, required this.sc});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      buildWhen: (previous, current) {
        if (current is SHomeGetAll) {
          return true;
        }
        if (current is SHomeLoading) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is SHomeGetAll) {
          return SliverAnimatedGrid(
            key: UniqueKey(),
            initialItemCount: state.lists.length,
            itemBuilder: (context, index, animation) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ItemDetailPage.nameRoute,
                      arguments: {'itemDetail': state.lists[index]});
                },
                child: CustomItem(
                  item: state.lists[index],
                ),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.75,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 2),
          );
        }

        if (state is SHomeLoading) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                    height: 50, width: 50, child: CircularProgressIndicator()),
              ),
            ),
          );
        }

        return const SliverToBoxAdapter(
          child: Text('empty'),
        );
      },
    );
  }
}

class LoadingMore extends StatelessWidget {
  const LoadingMore({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(buildWhen: (previous, current) {
      if (current is SHomeLoadMoreLoading) {
        return true;
      }
      if (current is SHomeGetAll) {
        return true;
      }
      if (current is SHomeLastPage) {
        return true;
      }
      return false;
    }, builder: (context, state) {
      if (state is SHomeLoadMoreLoading) {
        return SliverToBoxAdapter(
            child: Container(
          padding: const EdgeInsets.only(bottom: 10, top: 10),
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ));
      }
      if (state is SHomeLastPage) {
        return const SliverToBoxAdapter(
            child: SizedBox(
          height: 20,
          width: double.infinity,
          child: Align(alignment: Alignment.center, child: Text('Hết Dữ Liệu')),
        ));
      }
      return const SliverToBoxAdapter(child: SizedBox());
    });
  }
}
