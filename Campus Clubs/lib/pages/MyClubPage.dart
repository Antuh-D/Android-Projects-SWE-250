import 'dart:convert';
import 'package:campusclubs/components/MyAppBar.dart';
import 'package:campusclubs/components/MyClubsCardview.dart';
import 'package:campusclubs/config/AppRoutes.dart';
import 'package:campusclubs/config/AppString.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/AppGridViewBig.dart';
import '../components/AppGridViewSmall.dart';


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
        onProfileClick: (){
          Navigator.of(context).pushNamed(AppRoutes.profile);
        },
        Headding: AppString.myclubs,
      ),
      body:MyJoinedClub(),
    );
  }
}

class MyJoinedClub extends StatefulWidget {
  const MyJoinedClub({super.key});

  @override
  State<MyJoinedClub> createState() => _MyJoinedClubState();
}

class _MyJoinedClubState extends State<MyJoinedClub> {
  List<dynamic> yourClubs = [];
  List<dynamic> suggestedClubs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadClubs();
  }

  Future<void> loadClubs() async {
    final String response = await rootBundle.loadString('assets/data/clubs.json');
    final data = json.decode(response);

    setState(() {
      yourClubs = data["clubs"];
      suggestedClubs = data["suggested_clubs"];
      isLoading = false;
    });

  }
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

     return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            AppGridViewBig(
              cardData: yourClubs,
              cardsPerRow: 1,
              cardHeight: 160,
              spacing: 15,
              childAspectRatio: 1 / 1.2,
            ),
              SizedBox(height: 15,),
              Padding(
                padding: EdgeInsets.only(left:10,right: 10),
                child: Row(
                  children: [
                    Text('Discover More ',style: TextStyle(
                        color: Colors.black87,
                        fontSize: 21,
                        fontWeight: FontWeight.bold
                    ),),
                    Spacer(),
                    GestureDetector(
                      child: Text("View All",style: TextStyle(
                          color: Colors.green,fontWeight: FontWeight.bold)
                        ,),
                    )
                  ],
                ),
              ),
              SizedBox(height: 8,),
              AppGridViewSmall(
                cardData: suggestedClubs,
                cardsPerRow: 2,
                cardHeight: 250,
                cardWidth:150,
                spacing: 15,
                childAspectRatio: 1 / 1.2,
              ),
          ],
        ),
      ),
    );
  }
}

