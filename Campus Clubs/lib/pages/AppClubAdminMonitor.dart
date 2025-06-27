import 'package:campusclubs/components/MyAppBar.dart';
import 'package:flutter/material.dart';

class AppClubAdminMonitor extends StatefulWidget {
  const AppClubAdminMonitor({super.key});

  @override
  State<AppClubAdminMonitor> createState() => _AppClubAdminMonitorState();
}

class _AppClubAdminMonitorState extends State<AppClubAdminMonitor> {
  // Dummy club list
  final List<Map<String, dynamic>> clubs = [
    {
      "name": "Tech Talk: Future of AI",
      "category": "Technology",
      "members": 120,
    },
    {
      "name": "Photography Walk",
      "category": "Arts",
      "members": 45,
    },
    {
      "name": "Startup Pitch Night",
      "category": "Business",
      "members": 78,
    },
    {
      "name": "Poetry Slam",
      "category": "Literature",
      "members": 33,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        Headding: "Club Monitoring",
        backpage: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: clubs.length,
          itemBuilder: (context, index) {
            final club = clubs[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.purple.shade50,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    // Circular number badge
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.pinkAccent,
                      child: Text(
                        "${index + 1}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Club details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            club["name"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.category, size: 16, color: Colors.teal),
                              const SizedBox(width: 4),
                              Text(club["category"]),
                              const SizedBox(width: 12),
                              const Icon(Icons.group, size: 16, color: Colors.teal),
                              const SizedBox(width: 4),
                              Text("${club["members"]} members"),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Restrict Button
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Restricted ${club['name']}")),
                        );
                      },
                      child: const Text(
                        'Restrict',
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
