import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_track/application/home/home_bloc.dart';
import 'package:sky_track/application/user/user_bloc.dart';
import 'package:sky_track/core/colors.dart';
import 'package:sky_track/core/constants.dart';
import 'package:sky_track/domain/user/models/user_model.dart';

class UserCardWidget extends StatelessWidget {
  const UserCardWidget({
    super.key,
    required this.user,
    required this.onTap,
  });
  final UserModel user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const IconData emailIcon = IconData(0xf018, fontFamily: 'MaterialIcons');
    return Padding(
      padding: kEdgeInsetsHoriz16,
      child: Dismissible(
        key: ValueKey<UserModel>(user),
        direction: DismissDirection.endToStart,
        background: Container(
          padding: const EdgeInsets.only(right: 18),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: kBorderRadius12,
          ),
          child: const Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.delete_outline_rounded,
              color: kWhiteColor,
              size: 28,
            ),
          ),
        ),
        onDismissed: (DismissDirection direction) {
          context.read<UserBloc>().add(DeleteUserEvent(user.id));
          BlocProvider.of<HomeBloc>(context).add(FetchHomeUsersEvent());
        },
        child: GestureDetector(
          onTap: onTap,
          child: Material(
            elevation: 6,
            shadowColor: kLightGrey,
            borderRadius: kBorderRadius12,
            child: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: kCardColor,
                borderRadius: kBorderRadius12,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${user.firstName} ${user.lastName}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                  kHeight05,
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 5,
                    runSpacing: 5,
                    children: [
                      const Icon(
                        emailIcon,
                        size: 18,
                        color: kPrimaryColor,
                      ),
                      Text(
                        user.email,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
