import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/ItemDetail/bloc/item_detail_bloc.dart';

class ShopCustom extends StatelessWidget {
  const ShopCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemDetailBloc, ItemDetailState>(
      buildWhen: (previous, current) {
        if (current is SItemDetailGetShop) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is SItemDetailGetShop) {
          final shop = state.shop;
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  ListTile(
                      onTap: () {},
                      title: Text(
                        shop.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                      subtitle: Text("${shop.follower} người theo dõi"),
                      tileColor: Colors.grey.withOpacity(0.15),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      leading: ClipOval(
                        child: CircleAvatar(
                          radius: 25,
                          child: Image.network(shop.img),
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {},
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.network(
                              'https://cdn-icons-png.flaticon.com/128/3683/3683218.png'),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        }
        return SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                ListTile(
                  onTap: () {},
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  leading: const ClipOval(
                    child: CircleAvatar(
                      radius: 25,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                
              ],
            ),
          ),
        );
      },
    );
  }
}
