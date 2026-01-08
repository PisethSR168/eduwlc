import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eduwlc/constants/constant.dart';
import 'package:eduwlc/providers/auth_provider.dart';
import 'package:eduwlc/services/auth_service.dart';

class RequestReviewPage extends StatefulWidget {
  const RequestReviewPage({super.key});

  @override
  State<RequestReviewPage> createState() => _RequestReviewPageState();
}

class _RequestReviewPageState extends State<RequestReviewPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController(
    text: "Review Request",
  );
  final TextEditingController _bodyController = TextEditingController();

  int? _selectedTeacherId;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // Get teacher info from the enrollments in your JSON
    final authProvider = Provider.of<AuthProvider>(context);
    final enrollments = authProvider.userData?['enrollments'] ?? [];

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        title: const Text(
          "Request Review",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: kWhiteColor,
        foregroundColor: kDarkGreyColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select Teacher/Subject",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kGreyColor,
                ),
              ),
              const SizedBox(height: 10),

              // Dropdown to pick teacher from enrolled courses
              DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: kLightGreyColor.withOpacity(0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                hint: const Text("Choose a course"),
                value: _selectedTeacherId,
                items:
                    enrollments.map<DropdownMenuItem<int>>((dynamic emp) {
                      final course = emp['course_offering'];
                      return DropdownMenuItem<int>(
                        value:
                            course['teacher_id'], // This is the ID used for user_id in API
                        child: Text(
                          "${course['subject']['name']} (ID: ${course['teacher_id']})",
                        ),
                      );
                    }).toList(),
                onChanged: (val) => setState(() => _selectedTeacherId = val),
                validator:
                    (val) => val == null ? "Please select a teacher" : null,
              ),

              const SizedBox(height: 20),
              _buildLabel("Message Title"),
              TextFormField(
                controller: _titleController,
                decoration: _inputDecoration("e.g. Assignment Review"),
                validator: (v) => v!.isEmpty ? "Title is required" : null,
              ),

              const SizedBox(height: 20),
              _buildLabel("Your Message"),
              TextFormField(
                controller: _bodyController,
                maxLines: 5,
                decoration: _inputDecoration(
                  "Describe what you want the teacher to review...",
                ),
                validator:
                    (v) => v!.isEmpty ? "Message body is required" : null,
              ),

              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitRequest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child:
                      _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                            "Send Request",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitRequest() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final service = AuthService();
    final result = await service.sendRequestReview(
      teacherId: _selectedTeacherId!,
      title: _titleController.text,
      body: _bodyController.text,
    );

    setState(() => _isLoading = false);

    if (result['status'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Request sent successfully!"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? "Failed to send"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, color: kGreyColor),
    ),
  );

  InputDecoration _inputDecoration(String hint) => InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: kLightGreyColor.withOpacity(0.5),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    ),
  );
}
