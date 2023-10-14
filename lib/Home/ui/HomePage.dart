import 'package:easy_load_more/easy_load_more.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/Home/bloc/home_bloc.dart';
import 'package:login/Login/bloc/login_bloc.dart';
import 'package:login/Login/ui/LoginPage.dart';
import 'package:login/Model/User1.dart';

import 'Customitem.dart';
import 'HomeAppBar.dart';

class HomePage extends StatefulWidget {
  static const String nameRoute = '/HomePage';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
}

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    User1 user1 = context.read<LoginBloc>().acc!;
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is SHomeLogout) {
          Navigator.pushReplacementNamed(context, Login.nameRoute);
        }
      },
      child: Drawer(
        child: Column(children: [
          Container(
            width: double.infinity,
            height: 180,
            color: Colors.amber,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                user1.img != null
                    ? ClipOval(
                        child: CircleAvatar(
                          radius: 40,
                          child: Image.network(
                            user1.img!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : SizedBox(
                        child: CircleAvatar(
                          radius: 40,
                          child: Image.network(
                              'https://cdn-icons-png.flaticon.com/128/3135/3135715.png'),
                        ),
                      ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  user1.username,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          const ListTile(
            title: Text('thong tin tai khoang'),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              print('logout');
              context.read<HomeBloc>().add(EHomeLogout());
            },
            title: const Text('dang xuat'),
          ),
        ]),
      ),
    );
  }
}

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
              return CustomItem(
                item: state.lists[index],
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
