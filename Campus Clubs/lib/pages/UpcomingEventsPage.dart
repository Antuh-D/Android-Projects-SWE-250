import 'dart:convert';
import 'package:campusclubs/components/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For rootBundle
import '../components/EventGridView.dart';

class UpcomingEventsPage extends StatefulWidget {
  const UpcomingEventsPage({Key? key}) : super(key: key);

  @override
  _UpcomingEventsPageState createState() => _UpcomingEventsPageState();
}

class _UpcomingEventsPageState extends State<UpcomingEventsPage> {
  List<dynamic> upcomingEvents = [];
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

      setState(() {
        upcomingEvents = jsonResponse['upcoming'] ?? [];
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
    return Scaffold(
      appBar: MyAppBar(
        Headding: "All Upcoming Events",
        backpage: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : (upcomingEvents.isEmpty
            ? Center(child: Text('No Upcoming Events Found'))
            : EventGridView(
          events: upcomingEvents,
          cardsPerRow: 1,
          cardHeight: 160,
          number: upcomingEvents.length,
          spacing: 8,
        )),
      ),
    );
  }
}
