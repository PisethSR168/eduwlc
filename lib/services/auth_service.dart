import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Use 10.0.2.2 for Android Emulator
  static const String _baseUrl = "http://10.0.2.2:8000/api";
  static const String _tokenKey = 'auth_token';

  // --- 1. Login Function ---
  Future<bool> login(String username, String password) async {
    // Corrected to include /v1/
    final url = Uri.parse('$_baseUrl/v1/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': username,
          'password': password,
          'device_name': 'mobile',
        }),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final token = body['token'] ?? body['access_token'];

        if (token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(_tokenKey, token);
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // --- 2. Helper to retrieve the token ---
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // --- 3. Generic method for making authenticated GET requests ---
  Future<Map<String, dynamic>?> fetchData(String path) async {
    final token = await getToken();
    if (token == null) {
      return null;
    }

    final url = Uri.parse('$_baseUrl/v1/$path');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        return null;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // --- 4. Fetch User Profile Data (Uses fetchData) ---
  Future<Map<String, dynamic>?> getProfile() async {
    return await fetchData('profile');
  }

  // --- 5. Logout Function ---
  Future<bool> logout() async {
    final token = await getToken();
    final url = Uri.parse('$_baseUrl/v1/logout');

    // Always clear the local token, even if the API call fails
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);

    if (token == null) {
      return true;
    }

    try {
      await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // Server returns success or failure, but local token is gone either way
      return true;
    } catch (e) {
      return true;
    }
  }
}
