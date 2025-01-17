import 'package:flutter/material.dart';
import 'package:flutteroidctest/module/data/models/user_model.dart';

class UserCard extends StatelessWidget {
  final UserInfo user;
  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.blue.shade50,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Name: ${user.name}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 10),
              Text('Given Name: ${user.givenName}'),
              Text('Family Name: ${user.familyName}'),
              SizedBox(height: 10),
              Text('Email: ${user.email}'),
              Text(
                'Email Verified: ${(user.emailVerified ?? false) ? "Yes" : "No"}',
              ),
              SizedBox(height: 10),
              Text('Website: ${user.website ?? "N/A"}'),
              SizedBox(height: 10),
              Text('User ID: ${user.sub ?? "N/A"}'),
            ],
          ),
        ),
      ),
    );
  }
}
