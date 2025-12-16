import 'package:flutter/material.dart';
import 'package:eduwlc/screens/course_detail_page.dart';
import 'package:eduwlc/constants/constant.dart';
import 'package:eduwlc/models/subject.dart';
import 'package:eduwlc/services/subject_service.dart';
import 'package:intl/intl.dart';

class SubjectPage extends StatefulWidget {
  const SubjectPage({super.key});

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  final SubjectService _subjectService = SubjectService();
  final List<Subject> _subjects = [];
  int _currentPage = 1;
  int _lastPage = 1;
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchSubjects(isInitial: true);
  }

  Future<void> _fetchSubjects({
    int page = 1,
    bool isRefresh = false,
    bool isInitial = false,
  }) async {
    if (_isLoading && !isRefresh && !isInitial) return;

    if (isRefresh || isInitial) {
      setState(() {
        _subjects.clear();
        _currentPage = 1;
        _lastPage = 1;
        _hasError = false;
        _errorMessage = '';
      });
    }

    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final response = await _subjectService.fetchSubjects(page: page);

      if (mounted) {
        setState(() {
          _subjects.addAll(response.data);
          _currentPage = response.meta.currentPage;
          _lastPage = response.meta.lastPage;
        });
      }
    } catch (e) {
      if (mounted) {
        final errorMsg = 'Failed to load subjects: ${e.toString()}';
        setState(() {
          _hasError = true;
          _errorMessage = errorMsg;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMsg)));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_subjects.isEmpty && _isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

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
                    const Icon(
                      Icons.error_outline,
                      size: 80,
                      color: Colors.red,
                    ),
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
                        backgroundColor: const Color.fromARGB(255, 75, 51, 212),
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
                child: ListView.builder(
                  itemCount:
                      _subjects.length + (_currentPage < _lastPage ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _subjects.length) {
                      _fetchSubjects(page: _currentPage + 1);

                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
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
                                  (context) =>
                                      CourseDetailPage(subject: subject),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              Text(
                                'Department ID: ${subject.departmentId}',
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
                                  color: kDarkGreyColor.withAlpha(204),
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
