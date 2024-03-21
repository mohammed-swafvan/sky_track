import 'package:flutter/material.dart';
import 'package:sky_track/core/colors.dart';
import 'package:sky_track/core/constants.dart';
import 'package:sky_track/domain/user/models/user_model.dart';

class UserDataCardWidget extends StatelessWidget {
  const UserDataCardWidget({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Material(
      elevation: 5,
      shadowColor: kLightGrey,
      borderRadius: kBorderRadius10,
      child: Container(
        padding: const EdgeInsets.all(16),
        width: screenWidth,
        decoration: BoxDecoration(
          color: kCardColor,
          borderRadius: kBorderRadius10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customColumn("Full Name", "${user.firstName} ${user.lastName}"),
            kHeight10,
            customColumn("Email", user.email),
            kHeight10,
            customColumn("Location", user.city),
          ],
        ),
      ),
    );
  }

  Column customColumn(String label, String text) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: kSubtitleColor,
          ),
        ),
        kHeight05,
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: kBlackColor,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ],
    );
  }
}
