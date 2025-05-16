import 'package:donardiary/core/constants/app_colors_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData lightTheme = ThemeData(
    fontFamily: "Poppins",
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 40.sp,
        color: AppColors.appBlack,
        fontWeight: FontWeight.bold,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: AppColors.appAsh,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.appRed, width: 2),
        ), 
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.appBrown, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.appAsh, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.appRed, width: 1.0),
        ),
        labelStyle: const TextStyle(color: AppColors.appAsh),
        hintStyle: const TextStyle(color: AppColors.appAsh),
        fillColor: AppColors.appAsh.withOpacity(0.1),
        filled: true));
