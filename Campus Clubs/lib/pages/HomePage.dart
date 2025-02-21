import 'package:campusclubs/components/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/UserProvider.dart';
import '../components/MyAppBar.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: MyAppBar(),
      body: Center(
        child: user == null
            ? Text("No user logged in")
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome, ${user.name}!"),
            Text("Email: ${user.email}"),
          ],
        ),
      ),
    );
  }
}
