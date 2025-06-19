import 'package:flutter/material.dart';
import '../config/ClubModel.dart';

class AppClubViewPage extends StatelessWidget {
  final ClubModel club;

  const AppClubViewPage({Key? key, required this.club}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(club.name),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Club image
            ClipRRect(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              child: Image.asset(
                club.image,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            // Club name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                club.name,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Club subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Text(
                club.subtitle,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ),

            const Divider(height: 30, thickness: 1),

            // Stats
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(Icons.people, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text('${club.members} Active members'),
                  const Spacer(),
                  Icon(Icons.favorite, color: Colors.red),
                  const SizedBox(width: 6),
                  Text('${club.followers} followers'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Category
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.category, color: Colors.blueGrey),
                  const SizedBox(width: 6),
                  Text('Category: ${club.category}'),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                club.description ?? "No description available.",
                style: TextStyle(fontSize: 15, color: Colors.black87),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
