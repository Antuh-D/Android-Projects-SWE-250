import 'package:campusclubs/components/MyAppBar.dart';
import 'package:flutter/material.dart';

class AppClubAdminMonitor extends StatefulWidget {
  const AppClubAdminMonitor({super.key});

  @override
  State<AppClubAdminMonitor> createState() => _AppClubAdminMonitorState();
}

class _AppClubAdminMonitorState extends State<AppClubAdminMonitor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        Headding: "Club Monitoring",
        backpage: true,
      ),
      body: Center(
        child: Text("Monitoring"),
      ),
    );
  }
}
