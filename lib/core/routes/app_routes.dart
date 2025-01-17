import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutteroidctest/main.dart';
import 'package:flutteroidctest/module/presentation/pages/home_page.dart';
import 'package:flutteroidctest/module/presentation/pages/login_page.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GoRouter appRouter = GoRouter(
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
  ],
  redirect: (context, state) {
    final prefs = context.read<SharedPreferences>();
    final isAuthenticated = prefs.getString('accessToken') != null;

    if (isAuthenticated && state.location == '/') {
      return '/home';
    } else if (!isAuthenticated && state.location == '/home') {
      return '/';
    }

    return null;
  },
);
