import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../config/ClubModel.dart';
import '../config/ClubProvider.dart';
import '../components/AppClubSearchShow.dart';
import '../styles/AppColors.dart';
import 'AppClubViewPage.dart';
import 'AppEventDetailPage.dart';

class SearchPage extends StatefulWidget {
  @override
  _AppSearchPageState createState() => _AppSearchPageState();
}

class _AppSearchPageState extends State<SearchPage> {
  List<dynamic> allData = [];
  List<dynamic> filteredData = [];
  List<String> recentSearches = [];
  String query = "";

  @override
  void initState() {
    super.initState();
    _loadSearchableData();
  }

  Future<void> _loadSearchableData() async {
    final List<dynamic> combined = [];

    final String response = await rootBundle.loadString('assets/data/events.json');
    final Map<String, dynamic> jsonData = json.decode(response);

    final List<dynamic> upcoming = jsonData['upcoming'] ?? [];
    final List<dynamic> closed = jsonData['closed'] ?? [];

    combined.addAll(_mapEvents(upcoming));
    combined.addAll(_mapEvents(closed));

    final clubs = Provider.of<ClubProvider>(context, listen: false).clubs;
    combined.addAll(clubs.map((club) => {
      'type': 'club',
      'title': club.name,
      'category': club.category,
      'id': club.id,
      'image': club.image,
      'followers': club.followers,
      'clubObject': club,
    }));

    setState(() {
      allData = combined;
    });
  }

  List<Map<String, dynamic>> _mapEvents(List<dynamic> events) {
    return events
        .map((e) => {
      'type': 'event',
      'title': e['title'],
      'category': e['category'],
      'id': e['id'],
      'image': e['image'],
      'eventObject': e,
    })
        .toList();
  }

  void _handleSearch(String input) {
    setState(() {
      query = input;
      filteredData = input.isEmpty
          ? []
          : allData.where((item) =>
          item['title'].toLowerCase().contains(input.toLowerCase())).toList();
    });
  }

  void _addRecentSearch(String search) {
    if (!recentSearches.contains(search)) {
      setState(() => recentSearches.add(search));
    }
  }

  void _clearRecentSearches() {
    setState(() => recentSearches.clear());
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: _handleSearch,
        onSubmitted: (value) {
          _addRecentSearch(value);
          _handleSearch(value);
        },
        decoration: InputDecoration(
          hintText: "Search...",
          prefixIcon: const Icon(Icons.search),
          suffixIcon: query.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => setState(() {
              query = "";
              filteredData = [];
            }),
          )
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentSearches() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Recent Searches", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            TextButton(onPressed: _clearRecentSearches, child: const Text("Clear All", style: TextStyle(color: Colors.black))),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: recentSearches.length,
          itemBuilder: (context, index) {
            final search = recentSearches[index];
            return ListTile(
              title: Text(search),
              trailing: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => setState(() => recentSearches.removeAt(index)),
              ),
              onTap: () => _handleSearch(search),
            );
          },
        )
      ]),
    );
  }

  Widget _buildSearchResults() {
    return Expanded(
      child: ListView.builder(
        itemCount: filteredData.length,
        itemBuilder: (context, index) {
          final item = filteredData[index];

          if (item['type'] == 'club') {
            final ClubModel club = item['clubObject'];
            return AppClubSearchShow(
              club: item,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AppClubViewPage(club: club)),
              ),
            );
          }

          if (item['type'] == 'event') {
            final event = item['eventObject'];
            return ListTile(
              title: Text(event['title']),
              subtitle: Text('${event['date']} at ${event['time']}'),
              leading: const CircleAvatar(child: Icon(Icons.event, color: AppColors.accentPink)),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AppEventDetailPage(event: event)),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Expanded(
      child: Center(
        child: Text("You have no recent searches.", style: TextStyle(fontSize: 16, color: Colors.grey)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildSearchBar(),
          if (query.isEmpty && recentSearches.isNotEmpty) _buildRecentSearches(),
          if (query.isNotEmpty) _buildSearchResults(),
          if (query.isEmpty && recentSearches.isEmpty) _buildEmptyState(),
        ],
      ),
    );
  }
}
