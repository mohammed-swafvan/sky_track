import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:sky_track/core/colors.dart';

class SnackBarUtils {
  static Future<dynamic> customSnackBar(BuildContext context, String content) {
    return Flushbar(
      margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
      borderRadius: BorderRadius.circular(12),
      messageText: Container(
        alignment: Alignment.center,
        child: Text(
          content,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      flushbarStyle: FlushbarStyle.FLOATING,
      duration: const Duration(seconds: 2),
      backgroundGradient: const LinearGradient(
        colors: [
          kFirstGradientColor,
          kSecondGradientColor,
        ],
      ),
    ).show(context);
  }
}
