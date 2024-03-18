import 'package:flutter/material.dart';
import 'package:sky_track/core/colors.dart';
import 'package:sky_track/core/constants.dart';
import 'package:sky_track/presentation/sign_in/sign_in_screen.dart';
import 'package:sky_track/presentation/sign_up/sign_up_screen.dart';
import 'package:sky_track/presentation/welcome/widgets/welcome_button_widget.dart';
import 'package:sky_track/presentation/widgets/image_scaffold.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageScaffold(
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: kEdgeInsetsHoriz16,
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Welcome Back!\n",
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w600,
                          color: kWhiteColor,
                        ),
                      ),
                      TextSpan(
                        text:
                            "\nStep into a world of weather wonders! Your sunny companion for all forecasts. Stay ahead with us!",
                        style: TextStyle(
                          fontSize: 20,
                          color: kWhiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              const Expanded(
                child: WelcomeButtonWidget(
                  text: "Sign In",
                  navigateTo: SignInScreen(),
                  buttonColor: Colors.transparent,
                  textColor: kWhiteColor,
                ),
              ),
              Expanded(
                child: WelcomeButtonWidget(
                  text: "Sign Up",
                  navigateTo: const SignUpScreen(),
                  buttonColor: kWhiteColor.withOpacity(0.8),
                  textColor: kPrimaryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
