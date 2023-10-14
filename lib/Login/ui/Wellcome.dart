import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Home/ui/HomePage.dart';
import '../bloc/login_bloc.dart';
import 'LoginPage.dart';

class Wellcome extends StatefulWidget {
  const Wellcome({
    super.key,
  });

  @override
  State<Wellcome> createState() => _WellcomeState();
}

class _WellcomeState extends State<Wellcome> {
  @override
  void initState() {
    context.read<LoginBloc>().add(ELoginToken());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is SLoginToken) {
            if (state.result) {
              Navigator.pushReplacementNamed(context, HomePage.nameRoute);
            } else {
              Navigator.pushReplacementNamed(context, Login.nameRoute);
            }
          }
        },
        builder: (context, state) {
          if (state is SLoginLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return const Text('loi');
        },
      ),
    );
  }
}
