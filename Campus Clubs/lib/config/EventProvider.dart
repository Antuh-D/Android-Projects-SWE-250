import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'EventModel.dart';

class EventProvider with ChangeNotifier {
  List<EventModel> _events = [];
  bool _isLoading = false;
  String? _error;

  List<EventModel> get events => _events;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchEvents() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse("${dotenv.env['API_URL']}/api/events"));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _events = data.map((e) => EventModel.fromJson(e)).toList();
      } else {
        _error = "Failed to load events: ${response.statusCode}";
      }
    } catch (e) {
      _error = "Error: $e";
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearEvents() {
    _events = [];
    notifyListeners();
  }
}
