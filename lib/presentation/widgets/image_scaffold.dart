import 'package:flutter/material.dart';
import 'package:sky_track/core/image_strings.dart';

class ImageScaffold extends StatelessWidget {
  const ImageScaffold({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            ImageStrings.authScreenBgImage,
            height: screenHeight,
            width: screenWidth,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: child,
          ),
        ],
      ),
    );
  }
}
