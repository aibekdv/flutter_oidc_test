import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutteroidctest/module/data/models/user_model.dart';
import 'package:flutteroidctest/module/presentation/cubit/app_cubit.dart';
import 'package:flutteroidctest/module/presentation/widgets/user_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserInfo? userInfo;

  @override
  void initState() {
    context.read<AppCubit>().fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => context.read<AppCubit>().logout(),
          ),
        ],
      ),
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          if (state is UserInfoLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserInfoFailure) {
            return Center(
              child: ElevatedButton(
                onPressed: () => context.read<AppCubit>().fetchUserInfo(),
                child: Text("Try again"),
              ),
            );
          } else if (state is UserInfoLoaded) {
            userInfo = state.userInfo;
          }
          return userInfo == null
              ? Center(child: Text("No user info"))
              : Center(
                  heightFactor: 2,
                  child: UserCard(user: userInfo!),
                );
        },
      ),
    );
  }
}
