import 'package:flutter/material.dart';
import 'package:eduwlc/screens/course_detail_page.dart';
import 'package:eduwlc/constant.dart';
import 'package:eduwlc/models/subject.dart';
import 'package:eduwlc/models/paginated_response.dart';
import 'package:eduwlc/services/subject_service.dart';
import 'package:intl/intl.dart';

class SubjectPage extends StatefulWidget {
  const SubjectPage({super.key});

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  final SubjectService _subjectService = SubjectService();
  List<Subject> _subjects = [];
  int _currentPage = 1;
  int _lastPage = 1;
  bool _isLoadingMore = false;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchSubjects();
  }

  Future<void> _fetchSubjects({int page = 1, bool isRefresh = false}) async {
    if (isRefresh) {
      setState(() {
        _subjects.clear();
        _currentPage = 1;
        _hasError = false;
        _errorMessage = '';
      });
    }

    if (_isLoadingMore) return;

    setState(() {
      _isLoadingMore = true;
      _hasError = false;
      _errorMessage = '';
    });

    try {
      final response = await _subjectService.fetchSubjects(page: page);
      setState(() {
        _subjects.addAll(response.data);
        _currentPage = response.meta.currentPage;
        _lastPage = response.meta.lastPage;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = 'Failed to load subjects: ${e.toString()}';
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(_errorMessage)));
    } finally {
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        title: Text(
          'Subjects',
          style: TextStyle(
            color: kDarkGreyColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body:
          _hasError
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 80, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      _errorMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: kDarkGreyColor, fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => _fetchSubjects(isRefresh: true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        foregroundColor: kWhiteColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              )
              : RefreshIndicator(
                onRefresh: () => _fetchSubjects(isRefresh: true),
                child:
                    _subjects.isEmpty && _isLoadingMore
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                          itemCount:
                              _subjects.length + (_isLoadingMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == _subjects.length) {
                              if (_currentPage < _lastPage) {
                                _fetchSubjects(page: _currentPage + 1);
                                return const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            }

                            final subject = _subjects[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => CourseDetailPage(
                                            subject: subject,
                                          ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        subject.name,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: kDarkGreyColor,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Code: ${subject.code}',
                                        style: TextStyle(color: kGreyColor),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Department: ${subject.department.name}',
                                        style: TextStyle(color: kGreyColor),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Credit Hours: ${subject.creditHours}',
                                        style: TextStyle(color: kGreyColor),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        subject.description,
                                        style: TextStyle(
                                          color: kDarkGreyColor.withOpacity(
                                            0.8,
                                          ),
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          'Created: ${DateFormat('yyyy-MM-dd').format(subject.createdAt)}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: kLightGreyColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
              ),
    );
  }
}
