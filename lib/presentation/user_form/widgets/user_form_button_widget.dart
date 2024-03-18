import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_track/application/user/user_bloc.dart';
import 'package:sky_track/core/colors.dart';
import 'package:sky_track/core/constants.dart';

class UserFormButtonsWidget extends StatelessWidget {
  const UserFormButtonsWidget({super.key, required this.onCancelButton, required this.onCreateButton});
  final VoidCallback onCancelButton;
  final VoidCallback onCreateButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onCancelButton,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(kWhiteColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: kBorderRadius10,
                ),
              ),
            ),
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: kBlackColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        kWidth10,
        Expanded(
          child: ElevatedButton(
            onPressed: onCreateButton,
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return const SizedBox(
                    height: 26,
                    width: 26,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: kWhiteColor,
                    ),
                  );
                }
                return const Text(
                  "Create",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
