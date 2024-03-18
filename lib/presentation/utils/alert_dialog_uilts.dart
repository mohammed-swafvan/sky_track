import 'package:flutter/material.dart';
import 'package:sky_track/core/colors.dart';

class AlertDialoqUtils {
  static customAlertDialoque(
      {required BuildContext context, required VoidCallback onTap, required String title, required String content}) {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: kWhiteColor,
            title: Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            content: Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: kBlackColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onTap.call();
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
