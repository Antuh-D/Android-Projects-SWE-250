
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'UserModel.dart';
import 'ApiService.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  String? token;

  UserModel? get user => _user;

  Future<void> fetchUserByEmail(String email) async {
    final url = "${dotenv.env['API_URL']}/api/user/$email";

    try {
      final data = await ApiService.getRequest(url);
      _user = UserModel.fromJson(data);
    } catch (error) {
      print("Error fetching user: $error");
      _user = null;
    }

    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }

  void setToken(String newToken) {
    token = newToken;
    notifyListeners();
  }

  void updateUserFromJson(Map<String, dynamic> json) {
    _user = UserModel.fromJson(json);
    notifyListeners();
  }
}
