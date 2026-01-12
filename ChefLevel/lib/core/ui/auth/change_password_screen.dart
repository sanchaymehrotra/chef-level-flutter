import 'package:flutter/material.dart';
import 'package:food_chef/core/utils/constant/colors/app_color.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/common.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  // Heading
                  const Text(
                    'Change Password',
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Subtext
                  const Text(
                    'Set your new password',
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Current password
                  _buildPasswordField('Current password'),
                  const SizedBox(height: 20),
                  // New password
                  _buildPasswordField('New password'),
                  const SizedBox(height: 20),
                  // Confirm password
                  _buildPasswordField('Confirm password'),
                  const SizedBox(height: 30),
                  // Save button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.btnBackground,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // Handle password change logic
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField(String hint) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        obscureText: true,
        style: const TextStyle(color: AppColor.white),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock, color: AppColor.white),
          hintText: hint,
          hintStyle: const TextStyle(color: AppColor.white),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
