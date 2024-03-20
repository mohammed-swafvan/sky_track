import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_track/application/home/home_bloc.dart';
import 'package:sky_track/application/user/user_bloc.dart';
import 'package:sky_track/core/constants.dart';
import 'package:sky_track/presentation/user_form/widgets/user_form_button_widget.dart';
import 'package:sky_track/presentation/widgets/custom_scaffold.dart';
import 'package:sky_track/presentation/widgets/custom_text_fiield_widget.dart';
import 'package:sky_track/presentation/widgets/header_widget.dart';

class UserFormScreen extends StatefulWidget {
  const UserFormScreen({super.key});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final GlobalKey<FormState> userFormKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? city;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      header: HeaderWidget(
        onBackButton: () => Navigator.of(context).pop(),
        title: "User Form",
        subtitle: "You can create new user from here!",
      ),
      body: SingleChildScrollView(
        child: Form(
          key: userFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "First Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    kWidth04,
                    Expanded(
                      child: CustomTextFieldWidget(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "first name is required";
                          }
                          return null;
                        },
                        controller: firstNameController,
                        labelText: "first name",
                        hintText: "first name",
                        keyboardType: TextInputType.name,
                      ),
                    ),
                  ],
                ),
                kHeight25,
                Row(
                  children: [
                    const Text(
                      "Last Name ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    kWidth04,
                    Expanded(
                      child: CustomTextFieldWidget(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "last name is required";
                          }
                          return null;
                        },
                        controller: lastNameController,
                        labelText: "last name",
                        hintText: "last name",
                        keyboardType: TextInputType.name,
                      ),
                    ),
                  ],
                ),
                kHeight25,
                Row(
                  children: [
                    const Text(
                      "Valid Email",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    kWidth04,
                    Expanded(
                      child: CustomTextFieldWidget(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "email is required";
                          } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
                            return "enter valid email";
                          }
                          return null;
                        },
                        controller: emailController,
                        labelText: "email",
                        hintText: "email",
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ],
                ),
                kHeight25,
                Row(
                  children: [
                    const Text(
                      "City Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    kWidth04,
                    Expanded(
                      child: FormField<String>(
                        builder: (FormFieldState<String> field) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CSCPicker(
                                onCountryChanged: (value) {},
                                onStateChanged: (value) {},
                                onCityChanged: (value) {
                                  setState(() {
                                    city = value;
                                  });
                                  field.didChange(value);
                                },
                              ),
                              field.errorText != null
                                  ? Text(
                                      field.errorText!,
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 183, 35, 24),
                                        fontSize: 12,
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          );
                        },
                        validator: validateCity,
                      ),
                    ),
                  ],
                ),
                kHeight50,
                UserFormButtonsWidget(
                  onCancelButton: () {
                    clearForm();
                    Navigator.of(context).pop();
                  },
                  onCreateButton: () async {
                    if (userFormKey.currentState!.validate()) {
                      context.read<UserBloc>().add(
                            CreateUserEvent(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              email: emailController.text,
                              city: city!,
                            ),
                          );
                      BlocProvider.of<HomeBloc>(context).add(FetchHomeUsersEvent());

                      clearForm();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'City is required';
    }
    return null;
  }

  void clearForm() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    city = null;
  }
}
