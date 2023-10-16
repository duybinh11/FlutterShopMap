import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Login/bloc/login_bloc.dart';
import '../../Login/ui/LoginPage.dart';
import '../../Model/User1.dart';
import '../bloc/home_bloc.dart';

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
              context.read<HomeBloc>().add(EHomeLogout());
            },
            title: const Text('dang xuat'),
          ),
        ]),
      ),
    );
  }
}
