import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sky_track/application/sign_up/sign_up_bloc.dart';
import 'package:sky_track/core/colors.dart';
import 'package:sky_track/core/constants.dart';
import 'package:sky_track/domain/authentication/models/auth_model.dart';
import 'package:sky_track/presentation/home/home_screen.dart';
import 'package:sky_track/presentation/sign_in/sign_in_screen.dart';
import 'package:sky_track/presentation/utils/snack_bar_utils.dart';
import 'package:sky_track/presentation/welcome/welcome_screen.dart';
import 'package:sky_track/presentation/widgets/auth_header_tile_widget.dart';
import 'package:sky_track/presentation/widgets/custom_text_fiield_widget.dart';
import 'package:sky_track/presentation/widgets/image_scaffold.dart';
import 'package:get/get.dart' as fornavigate;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formSignUpKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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
            flex: 6,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 0.0),
              decoration: const BoxDecoration(
                color: kWhiteColor,
                borderRadius: kBorderRadiusVert40,
              ),
              child: SingleChildScrollView(
                child: BlocListener<SignUpBloc, SignUpState>(
                  listener: (context, state) {
                    if (state is SignUpSuccess) {
                      fornavigate.Get.off(
                        () => const HomeScreen(),
                      );
                    }

                    if (state is SignUpFailure) {
                      if (state.message == 'invalid-email') {
                        SnackBarUtils.customSnackBar(context, "The email address is baddly formated");
                      } else if (state.message == 'weak-password') {
                        SnackBarUtils.customSnackBar(context, "Password should be atleast 6 characters");
                      } else if (state.message == 'email-already-in-use') {
                        SnackBarUtils.customSnackBar(context, "This email is already exist");
                      } else {
                        SnackBarUtils.customSnackBar(context, state.message);
                      }
                    }
                  },
                  child: Form(
                    key: formSignUpKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Get Started",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        kHeight40,
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
                        kHeight15,
                        CustomTextFieldWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "password is required";
                            } else if (value.length < 8) {
                              return "enter minimum 8 characters";
                            }
                            return null;
                          },
                          controller: passwordController,
                          labelText: "password",
                          hintText: "Enter Your Password",
                          keyboardType: TextInputType.text,
                          isObscuredText: true,
                        ),
                        kHeight15,
                        CustomTextFieldWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "confirm password is required";
                            } else if (passwordController.text != confirmPasswordController.text) {
                              return "passwords are not the same";
                            }
                            return null;
                          },
                          controller: confirmPasswordController,
                          labelText: "confirm password",
                          hintText: "Enter Your Confirm Password",
                          keyboardType: TextInputType.text,
                          isObscuredText: true,
                        ),
                        kHeight40,
                        SizedBox(
                          width: double.maxFinite,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formSignUpKey.currentState!.validate()) {
                                AuthModel user = AuthModel.empty;
                                user = user.copyWith(userEmail: emailController.text);
                                setState(() {
                                  context.read<SignUpBloc>().add(
                                        SignUpRequired(
                                          user,
                                          passwordController.text,
                                        ),
                                      );
                                });
                              }
                            },
                            child: const Text(
                              "Sign up",
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
                              "Already have an Account?",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: kSubtitleColor,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                fornavigate.Get.off(
                                  () => const SignInScreen(),
                                  transition: fornavigate.Transition.fadeIn,
                                );
                              },
                              child: const Text(
                                " Sign In",
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
