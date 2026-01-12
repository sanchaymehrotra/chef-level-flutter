// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_chef/core/controller/user_controller.dart';
import 'package:food_chef/core/domain/di/service_locator.dart';
import 'package:food_chef/core/domain/models/user/check_profile_model.dart';
import 'package:food_chef/core/ui/home/home_screen.dart';
import 'package:food_chef/core/ui/preference_level/preference_level_screen.dart';
import 'package:food_chef/core/ui/widgets/loader/app_loader.dart';
import 'package:food_chef/core/utils/constant/colors/app_color.dart';
import 'package:food_chef/core/utils/constant/string/app_string.dart';
import 'package:food_chef/core/utils/constant/prefs/shared_pref.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/snackbar/bottom_snackbar.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String contact;
  final String password;
  final String loginMode;
  final String? otpCode;

  const OtpVerificationScreen({
    super.key,
    required this.contact,
    required this.password,
    required this.loginMode,
    required this.otpCode,
  });

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final txtController1 = TextEditingController();
  final txtController2 = TextEditingController();
  final txtController3 = TextEditingController();
  final txtController4 = TextEditingController();
  final txtController5 = TextEditingController();
  final txtController6 = TextEditingController();

  int totalTime = 30;
  var remainingTime = '0';
  Timer? timer;
  bool isCodeExpired = false;

  final userController = getIt.get<UserController>();

  @override
  void initState() {
    super.initState();
    setOtp(widget.otpCode!);
    startTimer();
  }

  Future<void> _verifyOtp() async {
    // Usage example:
    final Map<String, dynamic> data = {
      'contact': widget.contact.replaceAll(' ', ''),
      'otpCode':
          txtController1.text.toString() +
          txtController2.text.toString() +
          txtController3.text.toString() +
          txtController4.text.toString() +
          txtController5.text.toString() +
          txtController6.text.toString(),
      'password': widget.password,
      'loginMode': widget.loginMode,
    };

    DataModel apiResponse = await userController.verifyOtp(data);
    AppLoader.show(context);

    if (apiResponse.responseCode == 20000) {
      AppLoader.hide();
      final bool isPrefLevel = await SharedPrefService.isPrefLevel();
      await SharedPrefService.setLoggedIn(true);

      BottomSnackBar.show(
          context,
          message: 'Otp verified successfully.!!',
          backgroundColor: Colors.green,
          icon: Icons.check_circle
      );

      if (isPrefLevel) {
        //Home Screen open hogi

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      } else {
        AppLoader.hide();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => PreferenceLevelScreen()),
        );
      }
    } else {
      AppLoader.hide();
      BottomSnackBar.show(
          context,
          message: apiResponse.message!,
          backgroundColor: AppColor.btnBackground,
          icon: Icons.check_circle
      );
    }
  }

  Future<void> _resendOtp() async {
    // Usage example:
    final Map<String, dynamic> data = {
      'loginId': widget.contact.replaceAll(' ', ''),
      'loginMode': widget.loginMode,
      'password': widget.password,
    };

    DataModel apiResponse = await userController.login(data);
    AppLoader.show(context);

    if (apiResponse.responseCode == 20019) {
      AppLoader.hide();
      BottomSnackBar.show(
          context,
          message: 'Otp Resend : ${apiResponse.data!.check}',
          backgroundColor: AppColor.btnBackground,
          icon: Icons.check_circle
      );
      setOtp(apiResponse.data!.check);
    } else {
      AppLoader.hide();
      BottomSnackBar.show(
          context,
          message: apiResponse.message!,
          backgroundColor: AppColor.btnBackground,
          icon: Icons.check_circle
      );

    }
  }

  void setOtp(String? otp) {
    txtController1.text = otp![0];
    txtController2.text = otp[1];
    txtController3.text = otp[2];
    txtController4.text = otp[3];
    txtController5.text = otp[4];
    txtController6.text = otp[5];
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (totalTime > 0) {
        totalTime--;
        updatData();
      } else {
        setState(() {
          isCodeExpired = true;
        });
        timer.cancel();
      }
    });
  }

  void resendCode() {
    totalTime = 30; // Reset timer to 60 seconds
    setState(() {
      isCodeExpired = false;
    });
    clearTextFields(); // Clear the OTP field in the controller
    clearController(); // Clear the text fields in PinCodeTextField
    startTimer(); // Restart the timer
    updatData(); // Notify UI to update
  }

  int getOtpLength() {
    return txtController1.text.length +
        txtController2.text.length +
        txtController3.text.length +
        txtController4.text.length +
        txtController5.text.length +
        txtController6.text.length;
  }

  void disposeController() {
    txtController1.dispose();
    txtController2.dispose();
    txtController3.dispose();
    txtController4.dispose();
    txtController5.dispose();
    txtController6.dispose();
  }

  void clearTextFields() {
    txtController1.text = '';
    txtController2.text = '';
    txtController3.text = '';
    txtController4.text = '';
    txtController5.text = '';
    txtController6.text = '';
  }

  void clearController() {
    txtController1.text = '';
    txtController2.text = '';
    txtController3.text = '';
    txtController4.text = '';
    txtController5.text = '';
    txtController6.text = '';

    txtController1.clear();
    txtController2.clear();
    txtController3.clear();
    txtController4.clear();
    txtController5.clear();
    txtController6.clear();
  }

  void updatData() {
    setState(() {
      remainingTime = "00:${totalTime.toString().padLeft(2, '0')}";
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    disposeController();
    super.dispose();
  }

  Widget _textFieldOTP({
    bool? first,
    last,
    required TextEditingController otpController,
  }) {
    return SizedBox(
      height: 50,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          controller: otpController,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
          keyboardType: TextInputType.number,
          maxLength: 1,

          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: Color(0xFF8F8787)),
              borderRadius: BorderRadius.circular(6),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColor.white),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOtpFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _textFieldOTP(first: true, last: false, otpController: txtController1),
        _textFieldOTP(first: false, last: false, otpController: txtController2),
        _textFieldOTP(first: false, last: false, otpController: txtController3),
        _textFieldOTP(first: false, last: false, otpController: txtController4),
        _textFieldOTP(first: false, last: false, otpController: txtController5),
        _textFieldOTP(first: false, last: true, otpController: txtController6),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevent layout shift
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset('assets/images/common.png', fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.6)),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.arrow_back, color: AppColor.white),
                  SizedBox(height: 40),
                  Text(
                    AppString.otpVerification,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: AppColor.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '${widget.loginMode == 'mobile' ? 'Check your mobile, we have sent one time verification code to ' : 'Check your email, we have sent one time verification code to '}${widget.contact}.${AppString.verifyAccountMsg}',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.white,
                    ),
                  ),
                  SizedBox(height: 32),

                  // OTP fields in a row
                  _buildOtpFields(),

                  SizedBox(height: 32),

                  // Verify button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.btnBackground,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      if (!isCodeExpired &&
                          txtController1.text.isNotEmpty &&
                          txtController2.text.isNotEmpty &&
                          txtController3.text.isNotEmpty &&
                          txtController4.text.isNotEmpty &&
                          txtController5.text.isNotEmpty &&
                          txtController6.text.isNotEmpty) {
                        _verifyOtp();
                      }
                    },
                    child: Text(
                      AppString.verify,
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColor.white,
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  // Timer / Expired message
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isCodeExpired
                            ? "Your otp has expired please resend"
                            : remainingTime,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.white,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8),

                  // Resend button
                  TextButton(
                    onPressed: isCodeExpired
                        ? () {
                      resendCode();
                      _resendOtp();
                    }
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't get code? ",
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.white,
                          ),
                        ),
                        Text(
                          'Resend It',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.btnBackground,
                          ),
                        ),
                      ],
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
