import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool? readOnly;
  final void Function()? onTap;
  const CustomTextFormField(
      {super.key,
      this.prefixIcon,
      required this.hintText,
      this.textInputType,
      this.validator,
      this.suffixIcon,
      this.obscureText,
      this.readOnly,
      this.onTap,
      required this.controller,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      focusNode: focusNode,
      readOnly: readOnly ?? false,
      obscureText: obscureText ?? false,
      keyboardType: textInputType ?? TextInputType.text,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelText: hintText,
      ),
    );
  }
}
