import 'package:campusclubs/components/MyAppBar.dart';
import 'package:campusclubs/config/InterestProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppEventDetailPage extends StatelessWidget {
  final Map<String, dynamic> event;

  const AppEventDetailPage({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final interestProvider = Provider.of<InterestProvider>(context);
    final isInterested = interestProvider.isInterested(event['id'].toString()); // Use unique ID or title

    return Scaffold(
      appBar: MyAppBar(
        Headding: event['title'],
        backpage: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  Text(event['title'], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text("${event['club']} • ${event['category']}",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, size: 18, color: Colors.blue),
                      const SizedBox(width: 6),
                      Text("${event['date']} at ${event['time']}", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 18, color: Colors.redAccent),
                      const SizedBox(width: 6),
                      Text(event['location'], style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(event['description'], style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  interestProvider.toggleInterest(event['id'].toString());
                },
                icon: Icon(
                  Icons.star,
                  color: isInterested ? Colors.yellowAccent : Colors.white,
                  size: isInterested ? 30 : 24,
                  shadows: isInterested
                      ? [Shadow(blurRadius: 10, color: Colors.yellow, offset: Offset(0, 0))]
                      : [],
                ),
                label: Text(
                  isInterested ? 'Interested' : 'Mark as Interested',
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  backgroundColor: isInterested ? Colors.green : Colors.green,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
