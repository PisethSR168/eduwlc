import 'dart:convert';
import 'package:eduwlc/constants/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:eduwlc/models/subject.dart';
import 'package:eduwlc/models/paginated_response.dart';

class SubjectService {
  Future<PaginatedResponse<Subject>> fetchSubjects({int page = 1}) async {
    try {
      final response = await http.get(
        Uri.parse('${Appurl.url}/subjects?page=$page'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return PaginatedResponse<Subject>.fromJson(data, Subject.fromJson);
      } else {
        throw Exception('Failed to load subjects: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
