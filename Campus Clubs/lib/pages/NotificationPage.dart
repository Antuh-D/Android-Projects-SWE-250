import 'package:campusclubs/config/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/MyAppBar.dart';
import '../config/AppString.dart';
import '../config/UserProvider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: MyAppBar(
        Headding: AppString.notification,
        onProfileClick:(){
         Navigator.of(context).pushNamed(AppRoutes.profile);
        },
      ),
      body: Center(
        child: Center(child: Text("This Notification Page"),)
      ),
    );
  }
}
