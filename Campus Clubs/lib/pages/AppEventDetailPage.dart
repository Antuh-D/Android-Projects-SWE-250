import 'package:campusclubs/components/MyAppBar.dart';
import 'package:flutter/material.dart';

class AppEventDetailPage extends StatelessWidget {
  final Map<String, dynamic> event;

  const AppEventDetailPage({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        Headding: event['title'],
        backpage: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                event['image'],
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              event['title'],
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            // Club and Category
            Text(
              "${event['club']} • ${event['category']}",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),

            const SizedBox(height: 12),

            // Date and Time
            Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 18, color: Colors.blue),
                const SizedBox(width: 6),
                Text("${event['date']} at ${event['time']}",
                    style: TextStyle(fontSize: 16)),
              ],
            ),

            const SizedBox(height: 8),

            // Location
            Row(
              children: [
                Icon(Icons.location_on_outlined, size: 18, color: Colors.redAccent),
                const SizedBox(width: 6),
                Text(event['location'], style: TextStyle(fontSize: 16)),
              ],
            ),

            const SizedBox(height: 20),

            // Description
            Text(
              "Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              event['description'],
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
