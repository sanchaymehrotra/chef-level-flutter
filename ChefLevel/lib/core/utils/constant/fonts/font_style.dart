import 'dart:ui';
import 'package:food_chef/core/utils/constant/colors/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFontStyle {
  static final whiteText14NormalMont = GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: AppColor.white,
  );

  static final whiteText16NormalMont = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: AppColor.white,
  );

  static final whiteText14BoldMont = GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    color: AppColor.white,
  );

  static final redText12NormalMont = GoogleFonts.montserrat(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: AppColor.btnBackground,
  );

  static final whiteText30Bold = GoogleFonts.playfairDisplay(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    color: AppColor.white,
  );

  static final whiteText14Bold = GoogleFonts.playfairDisplay(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    color: AppColor.white,
  );
}
