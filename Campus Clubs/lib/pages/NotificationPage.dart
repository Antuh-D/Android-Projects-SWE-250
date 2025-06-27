import 'package:campusclubs/config/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/MyAppBar.dart';
import '../config/AppString.dart';
import '../config/UserProvider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Map<String, List<Map<String, dynamic>>> notifications = {
    "Today": [
      {"title": "SUST fitness club announced an event!", "time": "2:15 PM", "isNew": true},
      {"title": "Join Photography walk with Photography club !", "time": "1:40 PM", "isNew": true},
      {"title": "Wohooo you are now a member of SUST Robotics Club!", "time": "12:10 PM", "isNew": false},
    ],
    "Yesterday": [
      {"title": "New club added, have a visit!", "time": "3:39 PM", "isNew": false},
      {"title": "Your Club request has been approved!", "time": "11:23 AM", "isNew": false},
    ],
    "Monday, June 24, 2025": [
      {"title": "Reminder: Club registration closed", "time": "5:00 PM", "isNew": false},
      {"title": "New Hackathon Announced", "time": "10:15 AM", "isNew": false},
    ]
  };


  bool get hasUnread =>
      notifications.values.expand((list) => list).any((item) => item['isNew'] == true);

  Future<void> _refreshNotifications() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      notifications["Today"]!.insert(0, {
        "title": "📢 New CampusClub Event Posted!",
        "time": "Now",
        "isNew": true,
      });
    });
  }

  void _markAsRead(String section, int index) {
    setState(() {
      notifications[section]![index]['isNew'] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: MyAppBar(
        Headding: AppString.notification,
        onProfileClick: () {
          Navigator.of(context).pushNamed(AppRoutes.profile);
        },
      ),
      body: RefreshIndicator(
        onRefresh: _refreshNotifications,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: notifications.entries.map((entry) {
            String section = entry.key;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(
                    section,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                ...entry.value.asMap().entries.map((e) {
                  int index = e.key;
                  Map<String, dynamic> item = e.value;
                  return _NotificationTile(
                    item: item,
                    onTap: () {
                      _markAsRead(section, index);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Opened: ${item['title']}"),
                        duration: const Duration(seconds: 1),
                      ));
                    },
                  );
                }).toList(),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onTap;

  const _NotificationTile({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.mail_outline, color: Colors.blue[400]),
      title: Text(
        item['title'],
        style: TextStyle(
          fontSize: 15,
          fontWeight: item['isNew'] ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item['isNew']) const Icon(Icons.circle, color: Colors.red, size: 8),
          const SizedBox(width: 6),
          Text(item['time'], style: const TextStyle(color: Colors.grey)),
        ],
      ),
      onTap: onTap,
    );
  }
}
