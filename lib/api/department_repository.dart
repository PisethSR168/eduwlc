// Add your existing imports and code here

import 'dart:convert';
import 'package:eduwlc/constant.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // ... your existing methods ...
  static const String baseUrl = AppConstants.apiUrl;
  static Future<dynamic> delete(String endpoint, {String? token}) async {
    final url = Uri.parse('baseUrl/$endpoint');
    final headers = <String, String>{
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    final response = await http.delete(url, headers: headers);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isNotEmpty) {
        return jsonDecode(response.body);
      }
      return null;
    } else {
      throw Exception('Failed to delete: ${response.statusCode}');
    }
  }
}
