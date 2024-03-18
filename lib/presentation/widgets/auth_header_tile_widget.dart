import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sky_track/core/colors.dart';

class AuthHeaderTileWidget extends StatelessWidget {
  const AuthHeaderTileWidget({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: kWhiteColor.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Iconsax.arrow_left_2,
            color: kPrimaryColor,
            size: 20,
          ),
        ),
      ),
      title: const Text(
        "Back",
        style: TextStyle(
          fontSize: 18,
          color: kPrimaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
