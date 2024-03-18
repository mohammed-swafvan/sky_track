import 'package:flutter/material.dart';
import 'package:sky_track/core/colors.dart';
import 'package:sky_track/core/constants.dart';

class UserDataCardWidget extends StatelessWidget {
  const UserDataCardWidget({super.key, required this.label, required this.text});
  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: kBlackColor,
          ),
        ),
        kHeight05,
        Material(
          elevation: 5,
          shadowColor: kLightGrey,
          borderRadius: kBorderRadius10,
          child: Container(
            padding: const EdgeInsets.all(16),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: kCardColor,
              borderRadius: kBorderRadius10,
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kBlackColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
