import 'package:campusclubs/components/MyAppBar.dart';
import 'package:flutter/material.dart';

import '../config/AppRoutes.dart';
import '../config/AppString.dart';

class AppClubApprovalPage extends StatefulWidget {
  const AppClubApprovalPage({super.key});

  @override
  State<AppClubApprovalPage> createState() => _AppClubApprovalPageState();
}

class _AppClubApprovalPageState extends State<AppClubApprovalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        Headding: AppString.clubApproval,
        backpage: true,
      ),
      body: Center(
        child: Text("Write Application"),
      ),
    );
  }
}
