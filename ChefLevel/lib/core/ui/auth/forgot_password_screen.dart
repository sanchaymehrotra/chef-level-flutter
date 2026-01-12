import 'package:flutter/material.dart';
import 'package:food_chef/core/utils/constant/colors/app_color.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/common.png'), // Replace with your image path
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
                  // Back arrow
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppColor.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 40),
                  // Heading
                  const Text(
                    'Forgot Password',
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Subtext
                  const Text(
                    "Don't worry. It happens! Please enter registered email.",
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Email input field
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      style: const TextStyle(color: AppColor.white),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email, color: AppColor.white),
                        hintText: 'Email',
                        hintStyle: TextStyle(color: AppColor.white),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Send OTP button
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
                        // Handle OTP send logic
                      },
                      child: const Text(
                        'Send OTP',
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
}
