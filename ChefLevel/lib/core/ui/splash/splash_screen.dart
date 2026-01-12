// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_chef/core/ui/auth/login_screen.dart';
import 'package:food_chef/core/ui/home/home_screen.dart';
import 'package:food_chef/core/ui/preference_level/preference_level_screen.dart';
import 'package:food_chef/core/utils/constant/fonts/font_style.dart';
import 'package:food_chef/core/utils/constant/string/app_string.dart';
import 'package:food_chef/core/utils/constant/prefs/shared_pref.dart';
import 'package:google_fonts/google_fonts.dart';
import '../walkthrough/walkthrough_screen.dart';

class SplashScreen extends StatefulWidget {
  final bool isSeenWalkthrough;
  final bool isLoggedIn;

  const SplashScreen({
    super.key,
    required this.isSeenWalkthrough,
    required this.isLoggedIn,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Splash delay
    Timer(const Duration(seconds: 2), () async {
      if (widget.isSeenWalkthrough) {
        if (!widget.isLoggedIn) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => LoginScreen()),
          );
        } else {
          final bool isPrefLevel = await SharedPrefService.isPrefLevel();
          isPrefLevel
              ? Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => HomeScreen()),
                )
              : Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => PreferenceLevelScreen()),
                );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => WalkthroughScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                'assets/images/splash.png',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  "Version ${AppString.appVersion}",
                  style: AppFontStyle.whiteText16NormalMont,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
