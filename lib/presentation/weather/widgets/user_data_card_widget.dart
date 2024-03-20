import 'package:flutter/material.dart';
import 'package:sky_track/core/colors.dart';
import 'package:sky_track/core/constants.dart';

class UserDataCardWidget extends StatelessWidget {
  const UserDataCardWidget({super.key, required this.label, required this.text, this.city});
  final String label;
  final String text;
  final String? city;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Material(
      elevation: 5,
      shadowColor: kLightGrey,
      borderRadius: kBorderRadius10,
      child: Container(
        height: screenHeight / 6,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: kCardColor,
          borderRadius: kBorderRadius10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: kSubtitleColor,
              ),
            ),
            kHeight05,
            Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: kBlackColor,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            kHeight05,
            if (city != null)
              Text(
                city!,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: kBlackColor,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
          ],
        ),
      ),
    );
  }
}
