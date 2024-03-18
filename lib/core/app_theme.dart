import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sky_track/core/colors.dart';
import 'package:sky_track/core/constants.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    primarySwatch: Colors.blue,
    fontFamily: GoogleFonts.montserrat().fontFamily,
    scaffoldBackgroundColor: kWhiteColor,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: kBlackColor,
      ),
      bodySmall: TextStyle(
        color: kBlackColor,
      ),
      bodyMedium: TextStyle(
        color: kBlackColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(kEdgeInsetsVert10),
        foregroundColor: MaterialStateProperty.all<Color>(kWhiteColor),
        backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
        elevation: MaterialStateProperty.all<double>(4.0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: kBorderRadius10,
          ),
        ),
      ),
    ),
  );
}
