import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<dynamic> getRequest(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Request failed: ${response.statusCode}');
    }
  }
}
