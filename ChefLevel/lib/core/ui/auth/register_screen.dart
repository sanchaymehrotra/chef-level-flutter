// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:food_chef/core/controller/user_controller.dart';
import 'package:food_chef/core/domain/di/service_locator.dart';
import 'package:food_chef/core/domain/models/user/check_profile_model.dart';
import 'package:food_chef/core/ui/auth/login_screen.dart';
import 'package:food_chef/core/ui/widgets/loader/app_loader.dart';
import 'package:food_chef/core/utils/constant/colors/app_color.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/snackbar/bottom_snackbar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();

  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();

  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  final _cityController = TextEditingController();
  final _streetController = TextEditingController();
  final _unitController = TextEditingController();

  bool isEmail(String input) => EmailValidator.validate(input);
  bool isPhone(String input) => RegExp(
    r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$',
  ).hasMatch(input);

  final userController = getIt.get<UserController>();
  String? selectedValue = "+966";
  var textFontStyle = GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColor.white,
  );

  List<DropdownMenuItem<String>> get dropdownCountryEntries {
    return [
      DropdownMenuItem(
        value: '+966',
        child: Text('Saudi Arabia',style: textFontStyle)
      ),
      DropdownMenuItem(
        value: '+971',
        child: Text('Emairates',style: textFontStyle
      )),
      DropdownMenuItem(
        value: '+973',
        child: Text('Bahrain',style: textFontStyle)
      ),
      DropdownMenuItem(
        value: '+964',
        child: Text('Iraq',style: textFontStyle)
      ),
      DropdownMenuItem(
        value: '+965',
        child: Text('Kuwait',style: textFontStyle ))
      ,
      DropdownMenuItem(
        value: '+968',
        child: Text('Oman',style: textFontStyle)
      ),
      DropdownMenuItem(
        value: '+974',
        child: Text('Qatar',style: textFontStyle)
      ),
    ];
  }

  Future<void> _userRegistrationt() async {
    // Usage example:
    final Map<String, dynamic> data = {
      'username': _usernameController.text.toString(),
      'mobileNumber':selectedValue!+_mobileController.text.toString(),
      'email': _emailController.text.toString(),
      'firstName': _firstNameController.text.toString(),
      'lastName': _lastNameController.text.toString(),
      'pin': _passwordController.text.toString(),
      'city': _cityController.text.toString(),
      'street': _streetController.text.toString(),
      'unit': _unitController.text.toString(),
      'accountType': 'CUSTOMER',
    };
    AppLoader.show(context);
    DataModel apiResponse = await userController.createAccount(data);

    if (apiResponse.responseCode == 20000) {
      AppLoader.hide();
      BottomSnackBar.show(
        context,
        message: apiResponse.message!,
        backgroundColor: Colors.green,
        icon: Icons.check_circle,
      );
      // Redirect to login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Register',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    'Enter your personal data to create your account',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // First Name
                  _nameInputField(
                    'Username',
                    nameController: _usernameController,
                  ),
                  const SizedBox(height: 16),

                  // First Name
                  _nameInputField(
                    'First name',
                    nameController: _firstNameController,
                  ),
                  const SizedBox(height: 16),

                  // Last Name
                  _nameInputField(
                    'Last name',
                    nameController: _lastNameController,
                  ),
                  const SizedBox(height: 16),

                  // Email
                  _emailInputField('Email', emailController: _emailController),
                  const SizedBox(height: 16),

                  //Phone with country code
                  Row(
                    children: [
                      Container(
                        width: 160,
                        padding: EdgeInsets.only(left: 10.0, right: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: 
    //                     Row(
    // children: <Widget>[
    //   Icon(
    //     Icons.code,
    //     color: Colors.white,
    //     size: 20.0,
    //  ),
    //  Expanded(
                        
                       DropdownButtonHideUnderline(
                          child:DropdownButton(
                            value: selectedValue,
                            items: dropdownCountryEntries,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValue = newValue!;
                              });
                            },
                            style:textFontStyle,
                            dropdownColor: Colors.black,
                            icon: Icon(
                              Icons.arrow_drop_down_sharp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            controller: _mobileController,
                            maxLength: 15,
                            keyboardType: TextInputType.phone,
                            style: textFontStyle,
                            decoration: InputDecoration(
                              counterText: '',
                              prefixIcon: Padding(
            padding: const EdgeInsets.all(10.0), // Adjust padding as needed
            child: Image.asset(
              'assets/images/phone.png',
              width: 16,
              height: 16,
              fit: BoxFit.contain,
            ),
          ),
                              hintText: 'Phone number',
                              hintStyle:textFontStyle,
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Address
                  _addressInputField(
                    'City',
                    addressInputField: _cityController,
                  ),
                  const SizedBox(height: 16),

                  _addressInputField(
                    'Street',
                    addressInputField: _streetController,
                  ),
                  const SizedBox(height: 16),

                  _addressInputField(
                    'Unit',
                    addressInputField: _unitController,
                  ),
                  const SizedBox(height: 16),

                  _passwordInputField(
                    'Pin',
                    obscure: true,
                    passwordController: _passwordController,
                  ),
                  const SizedBox(height: 16),

                  // Confirm Password
                  _passwordInputField(
                    'Confirm pin',
                    obscure: true,
                    passwordController: _confirmController,
                  ),
                  const SizedBox(height: 30),

                  // Register Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.btnBackground,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () async {
                        // Handle registration logic
                        if (_usernameController.text.isNotEmpty &&
                            _firstNameController.text.isNotEmpty &&
                            _lastNameController.text.isNotEmpty &&
                            _emailController.text.isNotEmpty &&
                            _mobileController.text.isNotEmpty &&
                            _cityController.text.isNotEmpty &&
                            _streetController.text.isNotEmpty &&
                            _unitController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty &&
                            _confirmController.text.isNotEmpty) {
                          if (isEmail(
                            _emailController.text.toString().trim(),
                          )) {
                            if (isPhone(
                              _mobileController.text.toString().trim(),
                            )) {
                              if (_passwordController.text.length >= 4) {
                                if (_passwordController.text
                                        .toString()
                                        .trim() ==
                                    _confirmController.text.toString().trim()) {
                                  await _userRegistrationt();
                                } else {
                                  BottomSnackBar.show(
                                    context,
                                    message:
                                        'Pin & confirm pin should be same.!!',
                                    backgroundColor: AppColor.btnBackground,
                                    icon: Icons.error,
                                  );
                                }
                              } else {
                                BottomSnackBar.show(
                                  context,
                                  message:
                                      'Pin should be 4 to 8 character long.!!',
                                  backgroundColor: AppColor.btnBackground,
                                  icon: Icons.error,
                                );
                              }
                            } else {
                              BottomSnackBar.show(
                                context,
                                message:
                                    'Please enter correct mobile number.!!',
                                backgroundColor: AppColor.btnBackground,
                                icon: Icons.error,
                              );
                            }
                          } else {
                            BottomSnackBar.show(
                              context,
                              message: 'Please enter correct email id.!!',
                              backgroundColor: AppColor.btnBackground,
                              icon: Icons.error,
                            );
                          }
                        } else {
                          BottomSnackBar.show(
                            context,
                            message: 'Please enter all fields.!!',
                            backgroundColor: AppColor.btnBackground,
                            icon: Icons.error,
                          );
                        }
                      },
                      child: Text(
                        'Register',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Login prompt
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => LoginScreen()),
                          );
                        },
                        child: Text(
                          'Login',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColor.btnBackground,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _nameInputField(
    String hint, {
    required TextEditingController nameController,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(30),
      ),

      alignment: Alignment.center,

      child: TextField(
        controller: nameController,
        keyboardType: TextInputType.text,
        maxLength: 30,
        style: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColor.white,
        ),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          counterText: '',
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10.0), // Adjust padding as needed
            child: Image.asset(
              'assets/images/person.png',
              width: 16,
              height: 16,
              fit: BoxFit.contain,
            ),
          ),
          hintText: hint,
          hintStyle: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColor.white,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _emailInputField(
    String hint, {
    required TextEditingController emailController,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: emailController,
        maxLength: 60,
        style: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColor.white,
        ),
        textAlignVertical: TextAlignVertical.center,

        decoration: InputDecoration(
          counterText: '',

          prefixIcon: Padding(
            padding: const EdgeInsets.all(10.0), // Adjust padding as needed
            child: Image.asset(
              'assets/images/email.png',
              width: 16,
              height: 16,
              fit: BoxFit.contain,
            ),
          ),
          hintText: hint,
          hintStyle: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColor.white,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _addressInputField(
    String hint, {
    required TextEditingController addressInputField,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: addressInputField,
        textAlignVertical: TextAlignVertical.center,

        keyboardType: TextInputType.text,
        maxLength: 40,
        style: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColor.white,
        ),
        decoration: InputDecoration(
          counterText: '',
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10.0), // Adjust padding as needed
            child: Image.asset(
              'assets/images/address.png',
              width: 16,
              height: 16,
              fit: BoxFit.contain,
            ),
          ),
          hintText: hint,
          hintStyle: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColor.white,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _passwordInputField(
    String hint, {
    bool obscure = false,
    required TextEditingController passwordController,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: passwordController,
        textAlignVertical: TextAlignVertical.center,

        obscureText: obscure,
        maxLength: 8,
        keyboardType: TextInputType.number,
        style: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColor.white,
        ),
        decoration: InputDecoration(
          counterText: '',
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10.0), // Adjust padding as needed
            child: Image.asset(
              'assets/images/password.png',
              width: 16,
              height: 16,
              fit: BoxFit.contain,
            ),
          ),
          hintText: hint,
          hintStyle: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColor.white,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}


