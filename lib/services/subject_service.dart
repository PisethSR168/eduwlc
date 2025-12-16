import 'dart:convert';
import 'package:eduwlc/constants/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:eduwlc/models/subject.dart';
import 'package:eduwlc/models/paginated_response.dart';

class SubjectService {
  static String get _baseApiUrl => Appurl.url;

  Uri _buildUrl(String path, [Map<String, dynamic>? queryParameters]) {
    final uri = Uri.parse('$_baseApiUrl/v1/$path');

    if (queryParameters != null) {
      return uri.replace(
        queryParameters: Map<String, String>.from(queryParameters),
      );
    }
    return uri;
  }

  Future<PaginatedResponse<Subject>> fetchSubjects({
    int page = 1,
    String? token,
  }) async {
    final url = _buildUrl('subjects', {'page': page.toString()});

    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        return PaginatedResponse<Subject>.fromJson(data, Subject.fromJson);
      } else {
        throw Exception(
          'Failed to load subjects: ${response.statusCode} ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
