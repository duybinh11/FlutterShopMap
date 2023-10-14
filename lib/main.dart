import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/Banking/Bank/bloc/banking_bloc.dart';
import 'package:login/Cart/bloc/cart_bloc.dart';
import 'package:login/Cart/ui/CartPage.dart';
import 'package:login/Home/bloc/home_bloc.dart';
import 'package:login/Home/ui/HomePage.dart';
import 'package:login/ItemDetail/bloc/item_detail_bloc.dart';
import 'package:login/ItemDetail/ui/ItemDetailPage.dart';
import 'package:login/Login/bloc/login_bloc.dart';
import 'package:login/Banking/ui/BankingPage.dart';
import 'package:login/OrderDetail.dart/ui/OrderDetail.dart';
import 'package:login/OrderDetail/bloc/order_bloc.dart';
import 'package:login/OrderDetail/ui/OrderDetaliPage.dart';
import 'package:login/OrderList/bloc/order_list_bloc.dart';
import 'package:login/OrderList/ui/OrderMainPage.dart';
import 'package:login/Register/bloc/register_bloc.dart';
import 'package:login/Register/ui/RegisterPage.dart';
import 'package:login/SimpleBlocObserver%20.dart';

import 'Login/ui/LoginPage.dart';
import 'Login/ui/Wellcome.dart';

void main() {
  runApp(const MyApp());
  Bloc.observer = const SimpleBlocObserver();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        BlocProvider<ItemDetailBloc>(
          create: (context) => ItemDetailBloc(),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
        BlocProvider<OrderBloc>(
          create: (context) => OrderBloc(),
        ),
        BlocProvider<OrderListBloc>(
          create: (context) => OrderListBloc(),
        ),
        BlocProvider<BankingBloc>(
          create: (context) => BankingBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: '/',
        routes: {
          RegisterPage.nameRoute: (context) => RegisterPage(),
          HomePage.nameRoute: (context) => const HomePage(),
          Login.nameRoute: (context) => Login(),
          ItemDetailPage.nameRoute: (context) => const ItemDetailPage(),
          CartPage.nameRoute: (context) => const CartPage(),
          OrderDetailPage.routeName: (context) => const OrderDetailPage(),
          OrderMainPage.nameRoute: (context) => const OrderMainPage(),
          MbPage.nameRoute: (context) => const MbPage(),
          OrderDetailList.routeName: (context) => const OrderDetailList()
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  backgroundColor: Colors.blue)),
          inputDecorationTheme: const InputDecorationTheme(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 17, horizontal: 15),
              border: OutlineInputBorder(),
              labelStyle: TextStyle(fontSize: 18)),
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 27)),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Wellcome(),
      ),
    );
  }
}

AlertDialog showdialogcustom(
    String title, String content, BuildContext context) {
  return AlertDialog(
    title: Text(title),
    titleTextStyle: const TextStyle(
        fontSize: 25, color: Colors.blue, fontWeight: FontWeight.w600),
    content: Text(content),
    contentTextStyle: const TextStyle(color: Colors.black, fontSize: 17),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(
          'Đóng',
          style: TextStyle(color: Colors.black),
        ),
      )
    ],
  );
}

AlertDialog showdialogLoading() {
  return const AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(), // Hiển thị CircularProgressIndicator
        SizedBox(height: 16.0),
        Text("Đang tải..."), // Thêm văn bản mô tả (tuỳ chọn)
      ],
    ),
  );
}
