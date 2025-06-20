import 'package:flutter/material.dart';

class InterestProvider extends ChangeNotifier {
  final Map<String, bool> _interests = {};

  bool isInterested(String eventId) {
    return _interests[eventId] ?? false;
  }

  void toggleInterest(String eventId) {
    _interests[eventId] = !(_interests[eventId] ?? false);
    notifyListeners();
  }
}
