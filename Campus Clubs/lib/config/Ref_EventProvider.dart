import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'EventModel.dart';
import 'ApiService.dart';

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

    final url = "${dotenv.env['API_URL']}/api/events";

    try {
      final data = await ApiService.getRequest(url);
      _events = (data as List).map((e) => EventModel.fromJson(e)).toList();
    } catch (e) {
      _error = "Error loading events: $e";
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearEvents() {
    _events = [];
    notifyListeners();
  }
}