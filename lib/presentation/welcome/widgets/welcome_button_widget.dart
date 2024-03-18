import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky_track/core/constants.dart';

class WelcomeButtonWidget extends StatelessWidget {
  const WelcomeButtonWidget({
    super.key,
    required this.text,
    required this.navigateTo,
    required this.buttonColor,
    required this.textColor,
    this.borderRadius,
  });
  final Widget navigateTo;
  final String text;
  final Color buttonColor;
  final Color textColor;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.off(
          () => navigateTo,
          transition: Transition.fadeIn,
        );
      },
      child: Container(
        padding: kEdgeInsetsVert24,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: borderRadius,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
