import 'dart:convert';

import 'package:http/http.dart' as http;

class foodServices {
  static const BASE_URL = "https://www.themealdb.com/api/json/v1/1";
  
  Future<Map<String, dynamic>> getAllFood() async {
    final Map<String, String> headers = {
      'Accept': 'application/json'
    };
    
    try {
      final response = await http.get(
        Uri.parse(BASE_URL + "/search.php?f=a"),
        headers: headers,
      );

      return jsonDecode(response.body);
    } catch (e) {
      print("Error saat fetch Foods : $e");
      throw "Terjadi kesalahan saat fetch Foods";
    }
  }
}