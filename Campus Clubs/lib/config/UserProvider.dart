import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'UserModel.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  Future<void>fetchUserByEmail(String email) async{
    final url = Uri.parse("${dotenv.env['API_URL']}/api/user/$email");

    try{
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
       // print("Decoded JSON: $data");


        if (data == null) {
          throw Exception("Response data is null");
        }
        _user = UserModel(
          id: data['_id'],
          name: data['username'],
          email: data['email'],
          registation: data['registration'],
          role: data['role'],
        );
        notifyListeners(); // Update UI
      } else {
        throw Exception('Failed to load user');
      }
    }catch(error){
     print("Error fecthing user: $error");
    }
  }

  // Method to clear user on logout
  void logout() {
    _user = null;
    notifyListeners();
  }
}
