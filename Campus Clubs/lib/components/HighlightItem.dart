import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HighlightItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const HighlightItem({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.pink),
        const SizedBox(height: 4),
        Text(title,
            style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(subtitle, style: GoogleFonts.openSans(fontSize: 12)),
      ],
    );
  }
}