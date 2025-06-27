import 'dart:convert';
import 'package:campusclubs/components/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/EventGridView.dart';
class ClosedEventsPage extends StatefulWidget {
  const ClosedEventsPage({Key? key}) : super(key: key);

  @override
  _ClosedEventsPageState createState() => _ClosedEventsPageState();
}

class _ClosedEventsPageState extends State<ClosedEventsPage> {
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

      setState(() {
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
    return Scaffold(
      appBar: MyAppBar(Headding: "Closed Events",
        backpage: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : (closedEvents.isEmpty
            ? Center(child: Text('No Closed Events Found'))
            : EventGridView(
          events: closedEvents,
          cardsPerRow: 1,
          cardHeight: 160,
          number: closedEvents.length,
          spacing: 8,
        )),
      ),
    );
  }
}
