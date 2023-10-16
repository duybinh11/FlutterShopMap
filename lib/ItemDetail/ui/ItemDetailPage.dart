import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/Home/bloc/home_bloc.dart';
import 'package:login/Home/ui/Customitem.dart';
import 'package:login/Home/ui/HomePage.dart';
import 'package:login/ItemDetail/bloc/item_detail_bloc.dart';
import 'package:login/Model/Item.dart';
import 'package:login/main.dart';

import '../../Login/bloc/login_bloc.dart';
import 'ChangeCount.dart';
import 'ItemOther.dart';
import 'ShopCustom.dart';
import 'bottomItem.dart';

class ItemDetailPage extends StatefulWidget {
  static const String nameRoute = '/ItemDetailPage';
  const ItemDetailPage({super.key});

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  bool isTym = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Item itemDetail = map['itemDetail'] as Item;
    context.read<ItemDetailBloc>().add(EItemDetailGetItem(id: itemDetail.id));
    context
        .read<ItemDetailBloc>()
        .add(EItemDetailGetShop(idItem: itemDetail.id));
    return BlocConsumer<ItemDetailBloc, ItemDetailState>(
      listener: (context, state) {
        if (state is SItemDetailLoadingDialog) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => showdialogLoading(),
          );
        }
        if (state is SItemDetailAddCart) {
          Navigator.pop(context);
          String content = 'Thêm Giỏ Hàng Thất Bại';
          if (state.result) {
            content = 'Thêm Giỏ Hàng Thành Công';
            int id = context.read<LoginBloc>().acc!.id;
            context.read<HomeBloc>().add(EHomeGetCountCart(id: id));
          }
          showDialog(
            context: context,
            builder: (context) =>
                showdialogcustom('Giỏ Hàng', content, context),
          );
        }
      },
      buildWhen: (previous, current) {
        if (current is SItemDetailGetItem) {
          return true;
        }
        if (current is SItemDetailLoading) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is SItemDetailLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        if (state is SItemDetailErorr) {
          return const Text('loi');
        }
        if (state is SItemDetailGetItem) {
          Item item = state.item;
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      item.img,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.name,
                                style: const TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w700),
                              ),
                            ),
                            StatefulBuilder(
                              builder: (context, setState) => IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isTym = !isTym;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    size: 30,
                                    color: isTym ? Colors.red : Colors.black,
                                  )),
                            )
                          ],
                        ),
                        Text(
                          item.descrip,
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Giá : ${item.cost} VND',
                                style: const TextStyle(
                                    fontSize: 19,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const Text('Đánh Giá : 4.9 ',
                                style: TextStyle(
                                    fontSize: 19,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: Image.network(
                                  'https://cdn-icons-png.flaticon.com/128/1828/1828884.png'),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const ChangeCount(),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
                const ShopCustom(),
                const ItemOhter(),
              ],
            ),
            bottomNavigationBar: const BottomItem(),
          );
        }
        return const Text('sd');
      },
    );
  }
}
