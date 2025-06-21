import 'package:campusclubs/components/ClubGridViewSmall.dart';
import 'package:campusclubs/config/ClubModel.dart';
import 'package:flutter/material.dart';

import '../components/AppGridViewSmall.dart';
import '../components/MyAppBar.dart';
import '../config/AppString.dart';

class AppAllClubViewPage extends StatelessWidget {
  final List<ClubModel> clubs;
  const AppAllClubViewPage({super.key, required this.clubs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        Headding: "SUST Clubs",
        backpage: true,
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ClubGridViewSmall(cardData: clubs,number: clubs.length,)
            ],
          ),
        ),
      ),
    );
  }
}

