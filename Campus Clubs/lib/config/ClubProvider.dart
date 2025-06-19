import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import './ClubModel.dart';

class ClubProvider with ChangeNotifier {
  List<ClubModel> _clubs = [];

  List<ClubModel> get clubs => _clubs;

  Future<void> fetchAllClubs() async {
    final url = Uri.parse("${dotenv.env['API_URL']}/api/club");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _clubs = data.map((json) => ClubModel.fromJson(json)).toList();
        print(_clubs);
        notifyListeners();
      } else {
        throw Exception('Failed to load clubs');
      }
    } catch (error) {
      print("Error loading clubs: $error");
      _clubs = [];
      notifyListeners();
    }
  }

  ClubModel? getClubById(String id) {
    try {
      return _clubs.firstWhere((club) => club.id == id);
    } catch (e) {
      return null;
    }
  }

  void clearClubs() {
    _clubs = [];
    notifyListeners();
  }
}
