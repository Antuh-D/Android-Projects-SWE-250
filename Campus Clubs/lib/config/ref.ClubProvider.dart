import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'ClubModel.dart';
import 'ApiService.dart';

class ClubProvider with ChangeNotifier {
  List<ClubModel> _clubs = [];

  List<ClubModel> get clubs => _clubs;

  Future<void> fetchAllClubs() async {
    final url = "${dotenv.env['API_URL']}/api/club";

    try {
      final data = await ApiService.getRequest(url);
      _clubs = (data as List).map((json) => ClubModel.fromJson(json)).toList();
      notifyListeners();
    } catch (error) {
      print("Error loading clubs: $error");
      _clubs = [];
      notifyListeners();
    }
  }

  ClubModel? getClubById(String id) =>
      _clubs.firstWhere((club) => club.id == id, orElse: () => null as ClubModel);

  void clearClubs() {
    _clubs = [];
    notifyListeners();
  }
}
