import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sky_track/core/colors.dart';
import 'package:sky_track/core/constants.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({
    super.key,
    required this.onMenuButton,
    required this.onAddButton,
  });
  final VoidCallback onMenuButton;
  final VoidCallback onAddButton;

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
                  onPressed: onMenuButton,
                  icon: const Icon(
                    Iconsax.menu_1,
                    size: 28,
                    color: kWhiteColor,
                  ),
                ),
                kWidth10,
                const Text(
                  "Users List",
                  style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: onAddButton,
                  icon: const Icon(
                    Icons.add,
                    size: 26,
                    color: kWhiteColor,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: Text(
              "You can view the all users here!",
              style: TextStyle(
                color: kWhiteColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
