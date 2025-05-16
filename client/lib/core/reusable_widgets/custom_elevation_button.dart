import 'package:donardiary/core/constants/app_colors_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomButton extends StatelessWidget {
  final String text;
  final Color? buttonBackgroundColor;
  final Color? buttonTextColor;
  final VoidCallback onPressed;

 const CustomButton({
    super.key,
    required this.text,
     this.buttonBackgroundColor,
    this.buttonTextColor,
    required this.onPressed,
    
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonBackgroundColor ?? AppColors.appRed,
          foregroundColor: buttonTextColor ?? Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16), // Padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r), // Rounded corners
          ),
          elevation: 5, // Shadow elevation
        ),
        child: Text(
          text,
          style:  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}