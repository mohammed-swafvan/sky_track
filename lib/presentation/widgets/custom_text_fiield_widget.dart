import 'package:flutter/material.dart';
import 'package:sky_track/core/colors.dart';
import 'package:sky_track/core/constants.dart';

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget({
    super.key,
    required this.validator,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.keyboardType,
    this.isObscuredText,
  });
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final bool? isObscuredText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: isObscuredText ?? false,
      obscuringCharacter: '•',
      style: const TextStyle(
        fontWeight: FontWeight.w600,
      ),
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
        label: Text(labelText),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: kWhiteColor.withOpacity(0.05),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.black26,
        ),
        border: getTextFieldBorder,
        enabledBorder: getTextFieldBorder,
        errorMaxLines: 1,
      ),
    );
  }

  OutlineInputBorder get getTextFieldBorder {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.black12,
      ),
      borderRadius: kBorderRadius10,
    );
  }
}
