// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:food_chef/core/ui/auth/login_screen.dart';
import 'package:food_chef/core/ui/home/home_screen.dart';
import 'package:food_chef/core/ui/preference_level/preference_level_screen.dart';
import 'package:food_chef/core/utils/constant/colors/app_color.dart';
import 'package:food_chef/core/utils/constant/fonts/font_style.dart';
import 'package:food_chef/core/utils/constant/string/app_string.dart';
import 'package:food_chef/core/utils/constant/prefs/shared_pref.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({super.key});

  @override
  State<WalkthroughScreen> createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      "image": "assets/images/wth_1.jpg",
      "title": AppString.walkThroughTitle_1,
      "subtitle": AppString.walkThroughDesc_1,
    },
    {
      "image": "assets/images/wth_2.jpg",
      "title": AppString.walkThroughTitle_2,
      "subtitle": AppString.walkThroughDesc_2,
    },
    {
      "image": "assets/images/wth_3.jpg",
      "title": AppString.walkThroughTitle_3,
      "subtitle": AppString.walkThroughDesc_3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView
          PageView.builder(
            controller: _pageController,
            itemCount: pages.length,
            onPageChanged: (index) {
              setState(() => currentPage = index);
            },
            itemBuilder: (_, index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(pages[index]["image"]!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    // Skip button
                    Positioned(
                      top: 40,
                      right: 20,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => LoginScreen()),
                          );
                        },
                        child: Text(
                          AppString.skip,
                          style: AppFontStyle.whiteText14NormalMont,
                        ),
                      ),
                    ),

                    // Texts and dots + button
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 40,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              pages[index]["title"]!,
                              textAlign: TextAlign.center,
                              style: AppFontStyle.whiteText30Bold,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              pages[index]["subtitle"]!,
                              textAlign: TextAlign.center,
                              style: AppFontStyle.whiteText14NormalMont,
                            ),
                            const SizedBox(height: 20),

                            // Dots indicator
                            SmoothPageIndicator(
                              controller: _pageController,
                              count: pages.length,
                              effect: const WormEffect(
                                activeDotColor: AppColor.btnBackground,
                                dotColor: AppColor.white,
                                dotHeight: 10,
                                dotWidth: 10,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // // Next button (hide on last page if you want)
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await SharedPrefService.setWalkthroughSeen(
                                    true,
                                  );
                                  if (currentPage == pages.length - 1) {
                                    final bool isLoggedIn =
                                        await SharedPrefService.isLoggedIn();
                                    final bool isPrefLevel =
                                        await SharedPrefService.isPrefLevel();
                                    isLoggedIn
                                        ? isPrefLevel
                                              ? Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        const HomeScreen(),
                                                  ),
                                                )
                                              : Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        const PreferenceLevelScreen(),
                                                  ),
                                                )
                                        : Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  const LoginScreen(),
                                            ),
                                          );
                                  } else {
                                    _pageController.nextPage(
                                      duration: const Duration(
                                        milliseconds: 400,
                                      ),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.btnBackground,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80),
                                  ),
                                ),
                                child: Text(
                                  currentPage == pages.length - 1
                                      ? AppString.getStarted
                                      : AppString.next,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.white,
                                  ),
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
            },
          ),
        ],
      ),
    );
  }
}
