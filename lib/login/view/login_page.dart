import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:from_login/authentication_repository.dart';
import 'package:from_login/login/bloc/login_bloc.dart';
import 'package:from_login/login/view/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return LoginCubit(
                RepositoryProvider.of<AuthenticationRepository>(context));
          },
          child: const LoginScreen(),
        ),
      ),
    );
  }
}
