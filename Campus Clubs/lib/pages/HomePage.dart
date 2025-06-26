import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../components/EventGridView.dart';
import '../config/UserProvider.dart';
import '../config/AppRoutes.dart';
import '../config/AppString.dart';
import '../config/AppURL.dart';
import '../components/MyAppBar.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> upcomingEvents = [];
  List<dynamic> closedEvents = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  Future<void> loadEvents() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data/events.json');
      final Map<String, dynamic> jsonResponse = json.decode(jsonString);
     // print('Loaded JSON string: $jsonString');

      setState(() {
        upcomingEvents = jsonResponse['upcoming'] ?? [];
        closedEvents = jsonResponse['closed'] ?? [];
        isLoading = false;
      });
    } catch (e) {
      print('Error loading events JSON: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    final String? profilePicture = user?.profilePicture;
    final String baseUrl = (profilePicture != null && profilePicture.isNotEmpty)
        ? dotenv.env['API_URL']! + profilePicture
        : '';

    return Scaffold(
      appBar: MyAppBar(
        Headding: AppString.appname,
        onProfileClick: () => Navigator.of(context).pushNamed(AppRoutes.profile),
        onSettingsClick: () {},
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (user != null) ...[
              Center(
                child: ClipOval(
                  child: (baseUrl.isNotEmpty)
                      ? Image.network(
                    baseUrl,
                    width: 150,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Image.asset(AppURL.email_logo, width: 100, height: 100),
                  )
                      : Image.asset(AppURL.email_logo, width: 100, height: 100),
                ),
              ),
              SizedBox(height: 12),
              Center(child: Text("Welcome, ${user.name} To Explore more", style: TextStyle(fontSize: 17))),
            ],
            SizedBox(height: 35),

            Padding(
                padding: EdgeInsets.only(left: 13),
                child: Text("Upcoming Events", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
            if (isLoading)
              Center(child: CircularProgressIndicator())
            else if (upcomingEvents.isEmpty)
              Center(child: Text("No upcoming events found."))
            else
              EventGridView(
                events: upcomingEvents.take(2).toList(),
                cardsPerRow: 1,
                cardHeight: 160,
                number: upcomingEvents.length < 2 ? upcomingEvents.length : 2,
                spacing: 8,
                isInsideScroll: true,
              ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.upcomingEventsPage),
              child: Text("See All"),
            ),


            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 13),
                child: Text("Closed Events", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
            if (isLoading)
              Center(child: CircularProgressIndicator())
            else if (closedEvents.isEmpty)
              Center(child: Text("No closed events found."))
            else
              EventGridView(
                events: closedEvents.take(2).toList(), // show only 2 events
                cardsPerRow: 1,
                cardHeight: 160,
                number: closedEvents.length < 2 ? closedEvents.length : 2,
                spacing: 8,
                isInsideScroll: true,
              ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.closedEventsPage),
              child: Text("See All"),
            ),

          ],
        ),
      ),
    );
  }
}

