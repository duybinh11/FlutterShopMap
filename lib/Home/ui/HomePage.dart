import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/Home/bloc/home_bloc.dart';

import 'package:login/Login/bloc/login_bloc.dart';

import 'BodyHom.dart';
import 'HomeAppBar.dart';
import 'UserDrawer.dart';

class HomePage extends StatefulWidget {
  static const String nameRoute = '/HomePage';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final sc = ScrollController();
  @override
  void initState() {
    sc.addListener(() {
      if (sc.position.maxScrollExtent == sc.offset) {
        context.read<HomeBloc>().add(EHomeLoadMore());
      }
    });
    int id = context.read<LoginBloc>().acc!.id;
    context.read<HomeBloc>().add(EHomeGetCountCart(id: id));
    context.read<HomeBloc>().add(EHomeGetAll());
    context.read<HomeBloc>().add(EHomeGetCountOrder(id: id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<HomeBloc>().add(EHomeGetAll());
              return await Future.delayed(const Duration(seconds: 2));
            },
            edgeOffset: 100,
            child: CustomScrollView(
              controller: sc,
              slivers: [
                const HomeAppBar(),
                BodyHome(sc: sc),
                const LoadingMore(),
              ],
            ),
          )),
      drawer: const DrawerCustom(),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
