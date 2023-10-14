import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/Cart/bloc/cart_bloc.dart';
import 'package:login/Home/bloc/home_bloc.dart';

import 'package:login/Login/bloc/login_bloc.dart';

import 'CartCustom.dart';

class CartPage extends StatefulWidget {
  static const String nameRoute = '/CartPage';
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    int id = context.read<LoginBloc>().acc!.id;
    context.read<CartBloc>().add(ECartGetAll(id: id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ Hàng'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          int id = context.read<LoginBloc>().acc!.id;
          context.read<CartBloc>().add(ECartGetAll(id: id));
        },
        child: BlocConsumer<CartBloc, CartState>(
          listener: (context, state) {
            if (state is SCartDelete) {
              if (state.check) {
                int id = context.read<LoginBloc>().acc!.id;
                context.read<CartBloc>().add(ECartGetAll(id: id));
                context.read<HomeBloc>().add(EHomeGetCountCart(id: id));
              }
            }
          },
          buildWhen: (previous, current) {
            if (current is SCartDelete) {
              return false;
            }
            return true;
          },
          builder: (context, state) {
            if (state is SCartLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is SCartGetAll) {
              return ListView.builder(
                itemCount: state.list.length,
                itemBuilder: (context, index) =>
                    CartCustom(cartModel: state.list[index]),
              );
            }
            return const Text('null');
          },
        ),
      ),
    );
  }
}
