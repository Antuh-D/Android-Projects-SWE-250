import 'dart:io';

import 'package:campusclubs/components/MyAppBar.dart';
import 'package:campusclubs/config/AppString.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../config/UserProvider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;


    return Scaffold(
      appBar: MyAppBar(
        Headding: AppString.profile,
        backpage: true,
      ),
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
    ) ;
  }
}
