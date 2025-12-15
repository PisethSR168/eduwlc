import 'dart:convert';
import 'package:eduwlc/constants/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:eduwlc/models/book.dart';
import 'package:eduwlc/models/paginated_response.dart';

class BookService {
  Future<PaginatedResponse<Book>> fetchBooks({int page = 1}) async {
    try {
      final response = await http.get(
        Uri.parse('${Appurl.url}/books?page=$page'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return PaginatedResponse<Book>.fromJson(data, Book.fromJson);
      } else {
        throw Exception('Failed to load books: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
