import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:car_wash/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle style = const TextStyle(color: AppColors.greyColor);

const lightThemeFont = "Inter", darkThemeFont = "Inter";

final lightTheme = ThemeData(
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: AppColors.whiteColor,

  brightness: Brightness.light,
  useMaterial3: true,
  fontFamily: lightThemeFont,
  splashColor: Colors.transparent,
  inputDecorationTheme: const InputDecorationTheme(
      fillColor: AppColors.whiteColor,
      contentPadding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 24,
      ),
      hintStyle: TextStyle(color: AppColors.greyColor)),
  textTheme: TextTheme(
    bodySmall: const TextStyle(
      color: AppColors.greyColor,
    ),
    bodyMedium: GoogleFonts.inter(color: AppColors.greyColor, fontSize: 18),
    bodyLarge: const TextStyle(
      color: AppColors.greyColor,
    ),
    labelSmall: const TextStyle(
      color: AppColors.greyColor,
    ),
    labelMedium: const TextStyle(
      color: AppColors.greyColor,
    ),
    labelLarge: const TextStyle(
      color: AppColors.greyColor,
    ),
    displaySmall: const TextStyle(
      color: AppColors.greyColor,
    ),
    displayMedium: const TextStyle(
      color: AppColors.greyColor,
    ),
    displayLarge: const TextStyle(
      color: AppColors.greyColor,
    ),
  ),
  // switchTheme: SwitchThemeData(
  //   thumbColor:
  //       WidgetStateProperty.resolveWith<Color>((states) => lightThemeColor),
  // ),
  appBarTheme: AppBarTheme(
    //color:CustomColor.kPrimaryColorx,

    elevation: 0,
    centerTitle: false,
    iconTheme: const IconThemeData(color: AppColors.primaryColor),
    backgroundColor: AppColors.whiteColor,
    scrolledUnderElevation: 0,
    titleTextStyle: interMedium.copyWith(fontSize: 16.sp, color: black),
    actionsIconTheme: const IconThemeData(color: AppColors.primaryColor),
    systemOverlayStyle: const SystemUiOverlayStyle(
      // Status bar color
      statusBarColor: AppColors.whiteColor,
      // Status bar brightness (optional)
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.dark, // For iOS (dark icons)
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.whiteColor,
      elevation: 1,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryColor,
      showUnselectedLabels: true,
      selectedIconTheme: IconThemeData(size: 28),
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: TextStyle(color: AppColors.primaryColor)),
  // colorScheme: ColorScheme(background: CustomColor.whiteColor, brightness: null, primary: null, onPrimary: null)
);

// colors
const Color lightThemeColor = Colors.white,
    white = Colors.white,
    black = Colors.black,
    darkThemeColor = AppColors.primaryColor;
