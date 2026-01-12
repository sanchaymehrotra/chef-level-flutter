// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_chef/core/domain/di/service_locator.dart';
import 'package:food_chef/core/controller/user_controller.dart';
import 'package:food_chef/core/domain/models/user/check_profile_model.dart';
import 'package:food_chef/core/ui/auth/otp_verification_screen.dart';
import 'package:food_chef/core/ui/auth/register_screen.dart';
import 'package:food_chef/core/ui/home/home_screen.dart';
import 'package:food_chef/core/ui/preference_level/preference_level_screen.dart';
import 'package:food_chef/core/ui/widgets/loader/app_loader.dart';
import 'package:food_chef/core/ui/widgets/snackbar/bottom_snackbar.dart';
import 'package:food_chef/core/ui/widgets/custom_buttons/toggle_button.dart';
import 'package:food_chef/core/utils/constant/colors/app_color.dart';
import 'package:food_chef/core/utils/constant/string/app_string.dart';
import 'package:food_chef/core/utils/constant/prefs/shared_pref.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailMobileController = TextEditingController();
  final _passwordController = TextEditingController();
  int _toggleValue = -1;
  bool _obscurePassword = true;
  bool _isProfileExist = false;
  bool isEmail(String input) => EmailValidator.validate(input);
  bool isPhone(String input) => RegExp(
    r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$',
  ).hasMatch(input);
  String? selectedValue = "+966";
  final userController = getIt.get<UserController>();
  var textFontStyle = GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColor.white,
  );

  List<DropdownMenuItem<String>> get dropdownCountryEntries {
    return [
      DropdownMenuItem(
        value: '+966',
        child: Text('Saudi Arabia', style: textFontStyle),
      ),
      DropdownMenuItem(
        value: '+971',
        child: Text('Emairates', style: textFontStyle),
      ),
      DropdownMenuItem(
        value: '+973',
        child: Text('Bahrain', style: textFontStyle),
      ),
      DropdownMenuItem(
        value: '+964',
        child: Text('Iraq', style: textFontStyle),
      ),
      DropdownMenuItem(
        value: '+965',
        child: Text('Kuwait', style: textFontStyle),
      ),
      DropdownMenuItem(
        value: '+968',
        child: Text('Oman', style: textFontStyle),
      ),
      DropdownMenuItem(
        value: '+974',
        child: Text('Qatar', style: textFontStyle),
      ),
    ];
  }

  Future<void> _checkProfileExist() async {
    final Map<String, dynamic> data = {
      _toggleValue == -1 ? 'mobileNumber' : 'email': _toggleValue == -1
          ? selectedValue! + _emailMobileController.text.toString()
          : _emailMobileController.text.toString().toString().trim(),
      'loginMode': _toggleValue == -1 ? 'mobile' : 'email',
    };

    DataModel apiResponse = await userController.checkUserProfileExist(data);

    if (apiResponse.responseCode == 20000) {
      setState(() {
        _isProfileExist = false;
      });
      BottomSnackBar.show(
        context,
        message: 'No account found with this number/email, please register.!!',
        backgroundColor: AppColor.btnBackground,
        icon: Icons.error,
      );
    } else if (apiResponse.responseCode == 5120) {
      setState(() {
        _isProfileExist = true;
      });
      await SharedPrefService.setUid(apiResponse.data?.uid);

      if (_isProfileExist) {
        if (_passwordController.text.isNotEmpty &&
            _emailMobileController.text.isNotEmpty) {
          _checkLogin();
        } else {
          BottomSnackBar.show(
            context,
            message: apiResponse.message!,
            backgroundColor: AppColor.btnBackground,
            icon: Icons.check_circle,
          );
        }
      }
    } else {
      BottomSnackBar.show(
        context,
        message: apiResponse.message!,
        backgroundColor: AppColor.btnBackground,
        icon: Icons.check_circle,
      );
    }
  }

  Future<void> _checkLogin() async {
    final Map<String, dynamic> data = {
      'loginId': _toggleValue == -1
          ? selectedValue! + _emailMobileController.text.toString().trim()
          : _emailMobileController.text.toString().trim(),
      'loginMode': _toggleValue == -1 ? 'mobile' : 'email',
      'password': _passwordController.text.toString().trim(),
    };

    DataModel apiResponse = await userController.login(data);

    AppLoader.show(context);

    if (apiResponse.responseCode == 20000) {
      AppLoader.hide();
      setState(() {
        _isProfileExist = false;
      });
      final bool isPrefLevel = await SharedPrefService.isPrefLevel();
      await SharedPrefService.setLoggedIn(true);
      await SharedPrefService.setUserId(
        _emailMobileController.text.toString().trim(),
      );
      await SharedPrefService.setPin(
        _passwordController.text.toString().trim(),
      );

      BottomSnackBar.show(
        context,
        message: apiResponse.message!,
        backgroundColor: Colors.green,
        icon: Icons.check_circle,
      );
      if (isPrefLevel) {
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
    } else if (apiResponse.responseCode == 20019) {
      AppLoader.hide();
      setState(() {
        _isProfileExist = false;
      });
      // open OTP screen & pass the data
      //{"status":"SUCCESS","message":"SUCCESS","responseCode":20019,"data":{"check":"019931","uid":null}}

      await SharedPrefService.setUserId(
        _emailMobileController.text.toString().trim(),
      );
      await SharedPrefService.setPin(
        _passwordController.text.toString().trim(),
      );
      BottomSnackBar.show(
        context,
        message: 'Otp Sent : ${apiResponse.data!.check}',
        backgroundColor: Colors.green,
        icon: Icons.check_circle,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => OtpVerificationScreen(
            contact: _toggleValue == -1
                ? '${selectedValue!} ${_emailMobileController.text.toString().trim()}'
                : _emailMobileController.text.toString().trim(),
            password: _passwordController.text.toString(),
            loginMode: _toggleValue == -1 ? 'mobile' : 'email',
            otpCode: apiResponse.data?.check,
          ),
        ),
      );
    } else {
      AppLoader.hide();

      BottomSnackBar.show(
        context,
        message: apiResponse.message!,
        backgroundColor: AppColor.btnBackground,
        icon: Icons.check_circle,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/common.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.85),
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.85),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: AppColor.white),
                  ),

                  const SizedBox(height: 20),

                  // Title
                  Text(
                    AppString.login,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    AppString.enterYourLoginInformation,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 12),
                  AnimatedToggle(
                    values: ['Phone', 'Email'],
                    onToggleCallback: (value) {
                      setState(() {
                        _toggleValue = value;
                      });
                    },
                    buttonColor: AppColor.btnBackground,
                    backgroundColor: const Color(0xFFE2E2E2),
                  ),

                  const SizedBox(height: 16),

                  //Phone with country code
                  Row(
                    children: [
                      Visibility(
                        visible: _toggleValue == -1 ? true : false,
                        child: Container(
                          width: 160,
                          padding: EdgeInsets.only(left: 10.0, right: 5.0),
                          decoration: BoxDecoration(
                            color: AppColor.lightBlack.withOpacity(1.0),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: selectedValue,
                              items: dropdownCountryEntries,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue = newValue!;
                                });
                              },
                              style: textFontStyle,
                              dropdownColor: Colors.black,
                              icon: Icon(
                                Icons.arrow_drop_down_sharp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _toggleValue == -1 ? true : false,
                        child: SizedBox(width: 4),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.lightBlack.withOpacity(1.0),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: _buildMobileEmailInputField(
                            hint: _toggleValue == -1 ? 'Phone number' : 'Email',
                            textController: _emailMobileController,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Password
                  Visibility(
                    visible: _isProfileExist,
                    child: _buildPasswordInputField(
                      hint: AppString.password,
                      icon: Icons.lock_outline,
                      textController: _passwordController,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Forgot Password
                  Visibility(
                    visible: _isProfileExist,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          if (!isEmail(
                                _emailMobileController.text.toString().trim(),
                              ) &&
                              !isPhone(
                                _emailMobileController.text.toString().trim(),
                              )) {
                            BottomSnackBar.show(
                              context,
                              message:
                                  'Please enter correct email or phone number.!!',
                              backgroundColor: AppColor.btnBackground,
                              icon: Icons.error,
                            );
                          } else {
                            BottomSnackBar.show(
                              context,
                              message:
                                  'Link has been sent on your register email/mobile. Please reset Pin!!',
                              backgroundColor: Colors.green,
                              icon: Icons.check_circle,
                            );
                          }
                        },
                        child: Text(
                          AppString.forgotPassword,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: AppColor.btnBackground,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.btnBackground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () async {
                        if (!isEmail(
                              _emailMobileController.text.toString().trim(),
                            ) &&
                            !isPhone(
                              _emailMobileController.text.toString().trim(),
                            )) {
                          BottomSnackBar.show(
                            context,
                            message:
                                'Please enter correct email or phone number.!!',
                            backgroundColor: AppColor.btnBackground,
                            icon: Icons.error,
                          );
                        } else {
                          _checkProfileExist();
                        }
                      },
                      child: Text(
                        AppString.login,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),
                  // Register Text
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: AppString.dontAccount,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.white,
                        ),
                        children: [
                          TextSpan(
                            text: AppString.register,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.btnBackground,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => RegisterScreen(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileEmailInputField({
    required String hint,
    required TextEditingController textController,
  }) {
    return TextField(
      controller: textController,
      maxLength: _toggleValue == -1 ? 15 : 60,
      keyboardType: _toggleValue == -1
          ? TextInputType.phone
          : TextInputType.emailAddress,

      style: GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(10.0), // Adjust padding as needed
          child: Image.asset(
            _toggleValue == -1 ? 'assets/images/phone.png' : 'assets/images/email.png',
            width: 16,
            height: 16,
            fit: BoxFit.contain,
          ),
        ),
        counterText: '',
        suffixIcon: null,
        filled: true,
        fillColor: Colors.white.withOpacity(0.12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPasswordInputField({
    required String hint,
    required IconData icon,
    required TextEditingController textController,
  }) {
    return TextField(
      controller: textController,
      obscureText: _obscurePassword,
      maxLength: 8,
      keyboardType: TextInputType.number,
      style: GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        prefixIcon: Icon(icon, color: Colors.white70),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.white70,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
