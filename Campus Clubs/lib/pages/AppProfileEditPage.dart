import 'package:campusclubs/components/MyAppBar.dart';
import 'package:flutter/material.dart';

class AppProfileEditPage extends StatelessWidget {
  const AppProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        Headding: "Personal info",
        backpage: true,
      ),
      body: Center(
        child: Text("Edit User Info"),
      ),
    );
  }
}
