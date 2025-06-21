import 'dart:convert';
import 'package:campusclubs/components/ClubGridViewSmall.dart';
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
import 'AppAllClubViewPage.dart';

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
  late Future<void> _clubsFuture;

  @override
  void initState() {
    super.initState();
    _clubsFuture = Provider.of<ClubProvider>(context, listen: false).fetchAllClubs();
    loadClubs();
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

      return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ClubGridView(
              cardData: clubs,
              cardsPerRow: 1,
              cardHeight: 160,
              spacing: 3,
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
                    onTap: (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppAllClubViewPage(clubs:clubs),
                        ),
                      );
                    }
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
            ClubGridViewSmall(cardData:clubs, number: 4,)
          ],
        ),
      ),
    );
  }
}
