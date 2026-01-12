import 'package:flutter/material.dart';
import 'package:food_chef/core/ui/auth/login_screen.dart';
import 'package:food_chef/core/ui/auth/otp_verification_screen.dart';
import 'package:food_chef/core/ui/auth/register_screen.dart';
import 'package:food_chef/core/ui/home/home_screen.dart';
import 'package:food_chef/core/ui/preference_level/preference_level_screen.dart';
import 'package:food_chef/core/ui/walkthrough/walkthrough_screen.dart';
import '../ui/splash/splash_screen.dart';

class AppRoutes {
  AppRoutes._();
  static const String splashScreen = '/splash_page';
  static const String walkthroughScreen = '/walkthrough_screen';
  static const String loginScreen = '/login_screen';
  static const String otpLoginScreen = '/otp_login_screen';
  static const String registrationScreen = '/registration_screen';
  static const String prefsLevelScreen = '/preference_level_screen';
  static const String homeScreen = '/home_screen';




  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
        case splashScreen:
         return MaterialPageRoute(builder: (_) => const SplashScreen(isSeenWalkthrough: true,isLoggedIn: true));

        case walkthroughScreen:
          return MaterialPageRoute(builder: (_) => const WalkthroughScreen());

        case loginScreen:
          return MaterialPageRoute(builder: (_) => const LoginScreen());

        case otpLoginScreen:
         return MaterialPageRoute(builder: (_) => const OtpVerificationScreen(contact:'default',password:'default',loginMode:'',otpCode:'000000'));

          case registrationScreen:
         return MaterialPageRoute(builder: (_) =>  RegisterScreen());

         case prefsLevelScreen:
         return MaterialPageRoute(builder: (_) =>  PreferenceLevelScreen());

         
        case homeScreen:
          return MaterialPageRoute(builder: (_) => HomeScreen());

      default:
                return MaterialPageRoute(
                    builder: (_) => const Scaffold(
                      body: Center(
                        child: Text('Route not found'),
                      ),
                    )
                );

    }

  }
}