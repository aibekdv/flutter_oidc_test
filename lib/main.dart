import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutteroidctest/core/routes/app_routes.dart';
import 'package:flutteroidctest/module/data/services/api_service.dart';
import 'package:flutteroidctest/module/presentation/cubit/app_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/log/app_observer.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final service = ApiService(FlutterAppAuth(), Dio(), prefs);
  Bloc.observer = const AppBlocObserver(onLog: log);

  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider.value(value: service),
      RepositoryProvider.value(value: prefs),
    ],
    child: BlocProvider(
      create: (context) => AppCubit(service),
      child: BlocListener<AppCubit, AppState>(
        listener: (context, state) {
          if (state is LogoutLoaded) {
            navigatorKey.currentContext!.go('/');
          }
        },
        child: MyApp(),
      ),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter OIDC Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: appRouter,
    );
  }
}
