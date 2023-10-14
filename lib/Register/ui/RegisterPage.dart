import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/Register/bloc/register_bloc.dart';
import 'package:login/main.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  static const String nameRoute = '/RegisterPage';
  final keyForm = GlobalKey<FormState>();
  final emailCtl = TextEditingController(text: 'duybinh10@gmail.com');
  final passCtl = TextEditingController(text: 'zxc123');
  final pass2Ctl = TextEditingController(text: 'zxc123');
  final usernameCtl = TextEditingController(text: 'duybinh');

  String? checkEmail(String? value) {
    if (!value!.contains('@') || value.isEmpty) {
      return 'email khong hop le';
    }
    return null;
  }

  String? checkPass(String? value, String name) {
    if (value!.length < 5 || value.isEmpty) {
      return '$name khong hop le';
    }
    return null;
  }

  String? checkConfirm(String? value, String pass) {
    if (value!.length < 5 || value.isEmpty || pass != value) {
      return 'Xác Thực Mật Khẩu Không Hợp Lệ';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng Ký'),
      ),
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is SRegisterResult) {
            String x = 'Tạo tài khoản Thất Bại';
            if (state.result) {
              x = 'Tạo tài khoản thành công';
            }
            showDialog(
              context: context,
              builder: (context) => showdialogcustom('Message', x, context),
            );
          }
        },
        builder: (context, state) {
          if (state is SRegisterLoading) {
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
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: usernameCtl,
                      validator: (value) {
                        return checkPass(value, 'Username');
                      },
                      decoration: const InputDecoration(labelText: 'Username'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: passCtl,
                      validator: (value) => checkPass(value, 'Password'),
                      decoration: const InputDecoration(labelText: 'Password'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: pass2Ctl,
                      validator: (value) => checkConfirm(value, passCtl.text),
                      decoration:
                          const InputDecoration(labelText: 'Password Confirm'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (keyForm.currentState!.validate()) {
                          context.read<RegisterBloc>().add(ERegisterCreate(
                              email: emailCtl.text,
                              username: usernameCtl.text,
                              pass: passCtl.text));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50)),
                      child: const Text(
                        'Đăng Ký',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
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
