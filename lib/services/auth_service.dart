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
          print('Login successful. Token stored.');
          return true;
        } else {
          print('Login failed: Token not found in response.');
          return false;
        }
      } else {
        print('Login API Error (${response.statusCode}): ${response.body}');
        return false;
      }
    } catch (e) {
      print('Network Error during login: $e');
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
      print("No authentication token found. Cannot fetch data.");
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
        print(
          'Authorization Failed for $path: Token might be expired or invalid.',
        );
        return null;
      } else {
        print(
          'API Fetch Error (${response.statusCode}) for path $path: ${response.body}',
        );
        return null;
      }
    } catch (e) {
      print('Network Error during data fetch for $path: $e');
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
      print("Local token already cleared.");
      return true;
    }

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // Server returns success or failure, but local token is gone either way
      if (response.statusCode == 200 || response.statusCode == 204) {
        print('Server logout successful.');
      } else {
        print(
          'Logout failed on server side (${response.statusCode}). Local token cleared.',
        );
      }
      return true;
    } catch (e) {
      print('Network Error during logout. Local token cleared: $e');
      return true;
    }
  }
}
