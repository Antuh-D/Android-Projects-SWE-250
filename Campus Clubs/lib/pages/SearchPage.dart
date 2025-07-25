import 'package:campusclubs/components/AppClubSearchShow.dart';
import 'package:campusclubs/styles/AppColors.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../config/ClubModel.dart';
import '../config/ClubProvider.dart';
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
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    List<dynamic> combined = [];

    final String response = await rootBundle.loadString('assets/data/events.json');
    final Map<String, dynamic> jsonData = json.decode(response);

    if (jsonData.containsKey('upcoming')) {
      combined.addAll(jsonData['upcoming'].map((e) => {
        'type': 'event',
        'title': e['title'],
        'category': e['category'],
        'id': e['id'],
        'image': e['image'],
        'eventObject': e, // Store full event object here
      }));
    }

    if (jsonData.containsKey('closed')) {
      combined.addAll(jsonData['closed'].map((e) => {
        'type': 'event',
        'title': e['title'],
        'category': e['category'],
        'id': e['id'],
        'image': e['image'],
        'eventObject': e,
      }));
    }

    // Load clubs from provider
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


  void handleSearch(String input) {
    setState(() {
      query = input;
      if (input.isEmpty) {
        filteredData = [];
      } else {
        filteredData = allData
            .where((item) =>
            item['title'].toLowerCase().contains(input.toLowerCase()))
            .toList();
        print(filteredData);
      }
    });
  }

  void addRecentSearch(String search) {
    if (!recentSearches.contains(search)) {
      setState(() {
        recentSearches.add(search);
      });
    }
  }

  void clearRecentSearches() {
    setState(() {
      recentSearches.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final clubProvider = Provider.of<ClubProvider>(context);
    final clubs = clubProvider.clubs;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Search Bar
                Expanded(
                  child: TextField(
                    onChanged: (value) => handleSearch(value),
                    onSubmitted: (value) {
                      addRecentSearch(value);
                      handleSearch(value);
                    },
                    decoration: InputDecoration(
                      hintText: "Search...",
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: query.isNotEmpty ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            query = "";
                            filteredData = [];
                          });
                        },
                      ) : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.grey), // Gray border on focus
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Recent Searches Section
          if (query.isEmpty && recentSearches.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent Searches",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      TextButton(
                        onPressed: clearRecentSearches,
                        child: Text(
                          "Clear All",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: recentSearches.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(recentSearches[index]),
                        trailing: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              recentSearches.removeAt(index);
                            });
                          },
                        ),
                        onTap: () {
                          handleSearch(recentSearches[index]);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),


          // Filtered Data Section
          if (query.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  final item = filteredData[index];

                  if (item['type'] == 'club') {
                    final ClubModel club = item['clubObject'];
                    return AppClubSearchShow(
                      club: item,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AppClubViewPage(club: club),
                          ),
                        );
                      },
                    );
                  }
                  if (item['type'] == 'event') {
                    final event = item['eventObject'];
                    return ListTile(
                      title: Text(event['title']),
                      subtitle: Text('${event['date']} at ${event['time']}'),
                      leading: const CircleAvatar(child: Icon(Icons.event,color: AppColors.accentPink,)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AppEventDetailPage(event: event),
                          ),
                        );
                      },
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ),

          // Empty State Section
          if (query.isEmpty && recentSearches.isEmpty)
            const Expanded(
              child: Center(
                child: Text(
                  "You have no recent searches.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
        ],
      ),
    );
  }
}