import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:campusclubs/styles/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../components/MyAppBar.dart';
import '../config/ClubProvider.dart';

class AppClubAdminMonitor extends StatelessWidget {
   AppClubAdminMonitor({super.key});

  @override
  Widget build(BuildContext context) {
    final clubProvider = Provider.of<ClubProvider>(context);
    final clubs = clubProvider.clubs;

    return Scaffold(
      appBar: MyAppBar(
        Headding: "Monitor Clubs",
        backpage: true,
      ),
      body: clubs.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(13),
        itemCount: clubs.length,
        itemBuilder: (context, index) {
          final club = clubs[index];

          return Card(
            color: Colors.purple.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.only(bottom: 5),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        child: club.image.isNotEmpty
                            ? Image.memory(
                          base64Decode(club.image),
                          fit: BoxFit.cover,
                        )
                        :null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(club.name,
                                style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.category, size: 16, color: AppColors.accentPink),
                                const SizedBox(width: 4),
                                Text(club.category),
                                const SizedBox(width: 12),
                                const Icon(Icons.group, size: 16, color: AppColors.accentPink),
                                const SizedBox(width: 4),
                                Text("${club.followers} members"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      TextButton(onPressed: (){
                        restrictClub(context, club.id, club.name,clubProvider);
                      }, child: Text("Restrict",style: TextStyle(color: AppColors.accentPink)))
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

   Future<void> restrictClub(BuildContext context, String id, String name,ClubProvider clubProvider) async {
     final url = Uri.parse("${dotenv.env['API_URL']}/api/club/$id"); // Adjust URL as needed

     try {
       final response = await http.delete(url); // Or POST if your backend expects that

       if (response.statusCode == 200) {
         ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text("Restricted $name")),
         );
         await clubProvider.fetchAllClubs();
       } else {
         ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text("Failed to restrict $name")),
         );
       }
     } catch (e) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text("Error: $e")),
       );
     }
   }

}
