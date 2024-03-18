import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as fornavigate;
import 'package:sky_track/application/sign_in/sign_in_bloc.dart';
import 'package:sky_track/core/colors.dart';
import 'package:sky_track/core/constants.dart';
import 'package:sky_track/presentation/home/home_screen.dart';
import 'package:sky_track/presentation/sign_up/sign_up_screen.dart';
import 'package:sky_track/presentation/utils/snack_bar_utils.dart';
import 'package:sky_track/presentation/welcome/welcome_screen.dart';
import 'package:sky_track/presentation/widgets/auth_header_tile_widget.dart';
import 'package:sky_track/presentation/widgets/custom_text_fiield_widget.dart';
import 'package:sky_track/presentation/widgets/image_scaffold.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formSignInKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ImageScaffold(
      child: Column(
        children: [
          AuthHeaderTileWidget(
            onTap: () {
              fornavigate.Get.off(
                () => const WelcomeScreen(),
                transition: fornavigate.Transition.fadeIn,
              );
            },
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 0.0),
              decoration: const BoxDecoration(
                color: kWhiteColor,
                borderRadius: kBorderRadiusVert40,
              ),
              child: SingleChildScrollView(
                child: BlocListener<SignInBloc, SignInState>(
                  listener: (context, state) {
                    if (state is SignInSuccess) {
                      fornavigate.Get.off(
                        () => const HomeScreen(),
                      );
                    }

                    if (state is SignInFailure) {
                      if (state.message == 'user-not-found') {
                        SnackBarUtils.customSnackBar(context, "This user doesn't exist");
                      } else if (state.message == 'wrong-password') {
                        SnackBarUtils.customSnackBar(context, "Password is incorrect");
                      } else if (state.message == 'invalid-email') {
                        SnackBarUtils.customSnackBar(context, "Enter your email properly");
                      } else if (state.message == 'invalid-credential') {
                        SnackBarUtils.customSnackBar(context, "Email or Password something went wrong");
                      } else {
                        SnackBarUtils.customSnackBar(context, state.message!);
                      }
                    }
                  },
                  child: Form(
                    key: formSignInKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Welcome Back",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        kHeight50,
                        CustomTextFieldWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "email is required";
                            } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                              return "enter valid email";
                            }
                            return null;
                          },
                          controller: emailController,
                          labelText: "email",
                          hintText: "Enter Your Email",
                          keyboardType: TextInputType.emailAddress,
                        ),
                        kHeight20,
                        CustomTextFieldWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "password is required";
                            } else if (value.length < 8) {
                              return "enter valid password";
                            }
                            return null;
                          },
                          controller: passwordController,
                          labelText: "password",
                          hintText: "Enter Your Password",
                          keyboardType: TextInputType.text,
                          isObscuredText: true,
                        ),
                        kHeight40,
                        SizedBox(
                          width: double.maxFinite,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formSignInKey.currentState!.validate()) {
                                setState(() {
                                  context.read<SignInBloc>().add(
                                        SignInRequired(
                                          emailController.text,
                                          passwordController.text,
                                        ),
                                      );
                                });
                              }
                            },
                            child: const Text(
                              "Sign in",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        kHeight40,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have any Account?",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: kSubtitleColor,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                fornavigate.Get.off(
                                  () => const SignUpScreen(),
                                );
                              },
                              child: const Text(
                                " Sign Up",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
