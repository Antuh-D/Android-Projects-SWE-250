import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../styles/AppColors.dart';

class AppClubSearchShow extends StatelessWidget {
  final Map<String, dynamic> club;
  final VoidCallback? onTap;

  const AppClubSearchShow({super.key, required this.club, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.shade200,
              child: club['image'] != null && club['image'] != ""
                  ? ClipOval(
                child: Image.memory(
                  base64Decode(club['image']),
                  fit: BoxFit.cover,
                  width: 40,
                  height: 40,
                ),
              )
                  : const Icon(Icons.group, color: Colors.grey),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(club['title'],
                      style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.category, size: 14, color: AppColors.accentPink),
                      const SizedBox(width: 4),
                      Text(club['category'] ?? ""),
                      const SizedBox(width: 12),
                      const Icon(Icons.group, size: 14, color: AppColors.accentPink),
                      const SizedBox(width: 4),
                      Text("${club['followers']} followers"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
