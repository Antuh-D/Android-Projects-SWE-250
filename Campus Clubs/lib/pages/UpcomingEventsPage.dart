import 'dart:convert';
import 'package:campusclubs/styles/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/MyAppBar.dart';
import '../components/EventGridView.dart';

class UpcomingEventsPage extends StatefulWidget {
  const UpcomingEventsPage({Key? key}) : super(key: key);

  @override
  _UpcomingEventsPageState createState() => _UpcomingEventsPageState();
}

class _UpcomingEventsPageState extends State<UpcomingEventsPage> {
  List<dynamic> upcomingEvents = [];
  List<dynamic> filteredEvents = [];
  bool isLoading = true;
  String selectedCategory = 'All';
  bool isFilterOpen = false;

  final Map<String, IconData> categoryIcons = {
    'All': Icons.select_all,
    'Technology': Icons.memory,
    'Art & Media': Icons.brush,
    'Culture': Icons.public,
    'Sports': Icons.sports_soccer,
    'Theatre': Icons.theaters,
    'Academics': Icons.school,
    'Food': Icons.restaurant_menu,
  };

  Map<String, int> categoryCounts = {};

  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  Future<void> loadEvents() async {
    try {
      final String jsonString =
      await rootBundle.loadString('assets/data/events.json');
      final Map<String, dynamic> jsonResponse = json.decode(jsonString);
      final events = jsonResponse['upcoming'] ?? [];

      final counts = <String, int>{};
      for (var event in events) {
        String category = (event['category'] ?? 'Others').toString().trim();
        counts[category] = (counts[category] ?? 0) + 1;
      }

      setState(() {
        upcomingEvents = events;
        filteredEvents = events;
        categoryCounts = counts;
        categoryCounts['All'] = events.length;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading events JSON: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _applyCategoryFilter(String category) {
    setState(() {
      selectedCategory = category;
      isFilterOpen = false;
      if (category == 'All') {
        filteredEvents = upcomingEvents;
      } else {
        filteredEvents = upcomingEvents.where((event) {
          final cat = event['category']?.toString().toLowerCase() ?? '';
          return cat.contains(category.toLowerCase());
        }).toList();
      }
    });
  }

  Widget _buildCategoryList() {
    return Column(
      children: categoryIcons.entries.map((entry) {
        final isSelected = selectedCategory == entry.key;
        final count = categoryCounts[entry.key] ?? 0;
        return ListTile(
          leading: Icon(entry.value, color: isSelected ? Colors.blue : null),
          title: Text(entry.key),
          trailing: CircleAvatar(
            radius: 12,
            backgroundColor: Colors.pink,
            child: Text(
              "$count",
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
          selected: isSelected,
          selectedTileColor: Colors.blue.shade50,
          onTap: () => _applyCategoryFilter(entry.key),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isFilterApplied = selectedCategory != 'All';

    return Scaffold(
      appBar: MyAppBar(
        Headding: "All Upcoming Events",
        backpage: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    if (isFilterApplied) {
                      setState(() {
                        selectedCategory = 'All';
                        filteredEvents = upcomingEvents;
                        isFilterOpen = false;
                      });
                    } else {
                      setState(() {
                        isFilterOpen = !isFilterOpen;
                      });
                    }
                  },
                  icon: Icon(isFilterApplied || isFilterOpen
                      ? Icons.close
                      : Icons.filter_list),
                  label: Text(isFilterApplied
                      ? 'Clear Filter'
                      : isFilterOpen
                      ? 'Close Filters'
                      : 'Filter (${selectedCategory})' ,style: TextStyle(color: AppColors.accentPink),),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                if (isFilterApplied)
                  Chip(
                    label: Text(selectedCategory),
                    deleteIcon: const Icon(Icons.close),
                    onDeleted: () {
                      setState(() {
                        selectedCategory = 'All';
                        filteredEvents = upcomingEvents;
                      });
                    },
                  ),
              ],
            ),
            if (isFilterOpen) const SizedBox(height: 12),
            if (isFilterOpen) _buildCategoryList(),
            const SizedBox(height: 12),
            Expanded(
              child: filteredEvents.isEmpty
                  ? const Center(child: Text('No Upcoming Events Found'))
                  : EventGridView(
                events: filteredEvents,
                cardsPerRow: 1,
                cardHeight: 160,
                number: filteredEvents.length,
                spacing: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
