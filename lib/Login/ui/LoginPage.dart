import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/Home/ui/HomePage.dart';
import 'package:login/Login/bloc/login_bloc.dart';
import 'package:login/Register/ui/RegisterPage.dart';
import 'package:login/main.dart';

class Login extends StatelessWidget {
  Login({
    super.key,
  });
  static const String nameRoute = '/Login';
  final keyForm = GlobalKey<FormState>();
  final emailCtl = TextEditingController(text: 'duybinh10@gmail.com');
  final passCtl = TextEditingController(text: 'zxc123');

  String? checkEmail(String? value) {
    if (!value!.contains('@') || value.isEmpty) {
      return 'email khong hop le';
    }
    return null;
  }

  String? checkPass(String? value) {
    if (value!.length < 5 || value.isEmpty) {
      return 'Pass khong hop le';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is SLoginResult) {
            Navigator.pushReplacementNamed(context, HomePage.nameRoute);
          }
          if (state is SloginErorr) {
            String conten = 'Email  và Password không hợp lệ';

            showDialog(
              context: context,
              builder: (context) =>
                  showdialogcustom('Thông Báo', conten, context),
            );
          }
        },
        builder: (context, state) {
          if (state is SLoginLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Form(
                key: keyForm,
                child: Column(
                  children: [
                    const Spacer(
                      flex: 1,
                    ),
                    TextFormField(
                      controller: emailCtl,
                      validator: checkEmail,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: passCtl,
                      validator: checkPass,
                      decoration: const InputDecoration(labelText: 'Password'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (keyForm.currentState!.validate()) {
                          context.read<LoginBloc>().add(ELoginLogin(
                              email: emailCtl.text, pass: passCtl.text));
                        }
                      },
                      child: const Text(
                        'Đăng Nhập',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(child: const Text('Quên  Mật Khẩu')),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RegisterPage.nameRoute);
                            },
                            child: const Text('Tạo Tài Khoản'))
                      ],
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }
}
