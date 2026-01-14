import 'package:eduwlc/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:eduwlc/constants/constant.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  bool _isLoading = false;
  bool _isObscureCurrent = true;
  bool _isObscureNew = true;
  bool _isObscureConfirm = true;

  void _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_newPassController.text != _confirmPassController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match!"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final authService = AuthService();

    final result = await authService.changePassword(
      currentPassword: _currentPassController.text,
      newPassword: _newPassController.text,
      confirmPassword: _confirmPassController.text,
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (result['status'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? "Password updated!"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } else {
      String errorMsg = result['message'] ?? "Something went wrong";

      if (result['errors'] != null && result['errors'] is Map) {
        var errors = result['errors'];
        if (errors['new_password'] != null) {
          errorMsg = errors['new_password'][0];
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMsg), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        title: const Text(
          "Security",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: kWhiteColor,
        foregroundColor: kDarkGreyColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Change Password",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Your new password must be different from your previous used passwords.",
                style: TextStyle(color: kGreyColor, fontSize: 14),
              ),
              const SizedBox(height: 32),

              _buildPasswordField(
                controller: _currentPassController,
                label: "Current Password",
                isObscure: _isObscureCurrent,
                onToggle:
                    () =>
                        setState(() => _isObscureCurrent = !_isObscureCurrent),
              ),
              const SizedBox(height: 20),

              _buildPasswordField(
                controller: _newPassController,
                label: "New Password",
                isObscure: _isObscureNew,
                onToggle: () => setState(() => _isObscureNew = !_isObscureNew),
              ),
              const SizedBox(height: 20),

              _buildPasswordField(
                controller: _confirmPassController,
                label: "Confirm New Password",
                isObscure: _isObscureConfirm,
                onToggle:
                    () =>
                        setState(() => _isObscureConfirm = !_isObscureConfirm),
              ),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                  ),
                  child:
                      _isLoading
                          ? const CircularProgressIndicator(color: kWhiteColor)
                          : const Text(
                            "Update Password",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: kWhiteColor,
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

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool isObscure,
    required VoidCallback onToggle,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      validator: (value) => value!.isEmpty ? "Field cannot be empty" : null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: kGreyColor),
        filled: true,
        fillColor: kLightGreyColor.withValues(alpha: 0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: kPrimaryColor, width: 1),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isObscure ? Icons.visibility_off : Icons.visibility,
            color: kGreyColor,
          ),
          onPressed: onToggle,
        ),
      ),
    );
  }
}
