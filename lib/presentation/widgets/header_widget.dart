import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sky_track/core/colors.dart';
import 'package:sky_track/core/constants.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.onBackButton,
    required this.title,
    required this.subtitle,
    this.onLogOut,
  });
  final VoidCallback onBackButton;
  final String title;
  final String subtitle;
  final VoidCallback? onLogOut;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                IconButton(
                  onPressed: onBackButton,
                  icon: const Icon(
                    Iconsax.arrow_left,
                    size: 28,
                    color: kWhiteColor,
                  ),
                ),
                kWidth10,
                Text(
                  title,
                  style: const TextStyle(
                    color: kWhiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (onLogOut != null)
                  IconButton(
                    onPressed: onLogOut,
                    icon: const Icon(
                      Iconsax.logout,
                      size: 28,
                      color: kWhiteColor,
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 50, 24),
            child: Text(
              subtitle,
              style: const TextStyle(
                color: kWhiteColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
