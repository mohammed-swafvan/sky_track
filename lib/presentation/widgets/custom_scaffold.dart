import 'package:flutter/material.dart';
import 'package:sky_track/core/colors.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, required this.header, required this.body});
  final Widget header;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenHeight = size.height;
    final double screenWidth = size.width;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              kFirstGradientColor,
              kSecondGradientColor,
            ],
            begin: FractionalOffset(0.0, 0.4),
            end: Alignment.topRight,
          ),
        ),
        child: Column(
          children: [
            header,
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(60),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(60),
                  ),
                  child: body,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
