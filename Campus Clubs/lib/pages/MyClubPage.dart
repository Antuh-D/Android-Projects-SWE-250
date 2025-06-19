import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:campusclubs/components/MyAppBar.dart';
import 'package:campusclubs/config/AppRoutes.dart';
import 'package:campusclubs/config/AppString.dart';
import '../config/ClubModel.dart';
import '../config/ClubProvider.dart';
import '../components/AppGridViewSmall.dart';
import '../components/ClubGridView.dart';

class MyClubPage extends StatefulWidget {
  const MyClubPage({super.key});

  @override
  State<MyClubPage> createState() => _MyClubPageState();
}

class _MyClubPageState extends State<MyClubPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        onProfileClick: () {
          Navigator.of(context).pushNamed(AppRoutes.profile);
        },
        Headding: AppString.myclubs,
      ),
      body: MyJoinedClub(),
    );
  }
}

class MyJoinedClub extends StatefulWidget {
  const MyJoinedClub({super.key});

  @override
  State<MyJoinedClub> createState() => _MyJoinedClubState();
}

class _MyJoinedClubState extends State<MyJoinedClub> {
  List<ClubModel> yourClubs = [];
  List<ClubModel> suggestedClubs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadClubs();
    Provider.of<ClubProvider>(context, listen: false).fetchAllClubs();
  }

  Future<void> loadClubs() async {
    final String response = await rootBundle.loadString('assets/data/clubs.json');
    final data = json.decode(response);

    setState(() {
      yourClubs = (data["clubs"] as List)
          .map((club) => ClubModel.fromJson(club))
          .toList();
      suggestedClubs = (data["clubs"] as List)
          .map((club) => ClubModel.fromJson(club))
          .toList();
      print(yourClubs);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final clubProvider = Provider.of<ClubProvider>(context);
    final clubs = clubProvider.clubs;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ClubGridView(
              cardData: clubs,
              cardsPerRow: 1,
              cardHeight: 160,
              spacing: 15,
              childAspectRatio: 1 / 1.2,
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Text(
                    'Discover More ',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    child: const Text(
                      "View All",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
            AppGridViewSmall(
              cardData: suggestedClubs,
              cardsPerRow: 2,
              cardHeight: 250,
              cardWidth: 100,
              spacing: 5,
              childAspectRatio: 1 / 1.2,
            ),
          ],
        ),
      ),
    );
  }
}
