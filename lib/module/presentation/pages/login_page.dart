import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutteroidctest/module/presentation/cubit/app_cubit.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          if (state is LoginLoaded) {
            context.go('/home');
          }
        },
        builder: (context, state) {
          return Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<AppCubit>().login();
              },
              child: Text("Login"),
            ),
          );
        },
      ),
    );
  }
}
