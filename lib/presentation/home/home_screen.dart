import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_track/application/home/home_bloc.dart';
import 'package:sky_track/application/user/user_bloc.dart';
import 'package:sky_track/application/weather/weather_bloc.dart';
import 'package:sky_track/core/colors.dart';
import 'package:sky_track/core/constants.dart';
import 'package:sky_track/domain/user/models/user_model.dart';
import 'package:sky_track/infastructure/user/firebase_user_repository.dart';
import 'package:sky_track/presentation/home/widgets/home_header_widget.dart';
import 'package:get/get.dart' as fornavigate;
import 'package:sky_track/presentation/home/widgets/user_card_widget.dart';
import 'package:sky_track/presentation/user_form/user_form_screen.dart';
import 'package:sky_track/presentation/weather/weather_screen.dart';
import 'package:sky_track/presentation/widgets/custom_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(FetchHomeUsersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HomeBloc>(context).add(FetchHomeUsersEvent());
      },
      child: CustomScaffold(
        header: HomeHeaderWidget(
          onMenuButton: () {},
          onAddButton: () {
            fornavigate.Get.to(
              BlocProvider(
                create: (context) => UserBloc(userService: FirebaseUserRepository()),
                child: const UserFormScreen(),
              ),
              transition: fornavigate.Transition.fadeIn,
            );
          },
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState || state is HomeInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HomeSuccessState) {
              if (state.users.isEmpty) {
                return Center(
                  child: IconButton(
                    onPressed: () {
                      fornavigate.Get.to(
                        BlocProvider(
                          create: (context) => UserBloc(userService: FirebaseUserRepository()),
                          child: const UserFormScreen(),
                        ),
                        transition: fornavigate.Transition.fadeIn,
                      );
                    },
                    icon: const Icon(
                      Icons.add_circle_outline_rounded,
                      color: kPrimaryColor,
                      size: 50,
                    ),
                  ),
                );
              }

              return ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: state.users.length,
                itemBuilder: ((context, index) {
                  final UserModel user = state.users[index];

                  return BlocProvider<UserBloc>(
                    create: (context) => UserBloc(userService: FirebaseUserRepository()),
                    child: index % 2 == 0
                        ? FadeInRight(
                            delay: const Duration(milliseconds: 800),
                            child: UserCardWidget(
                              onTap: () {
                                fornavigate.Get.to(
                                  BlocProvider(
                                    create: (context) => WeatherBloc(),
                                    child: WeatherScreen(user: user),
                                  ),
                                  transition: fornavigate.Transition.fadeIn,
                                );
                              },
                              user: user,
                            ),
                          )
                        : FadeInLeft(
                            delay: const Duration(milliseconds: 800),
                            child: UserCardWidget(
                              onTap: () {
                                fornavigate.Get.to(
                                  BlocProvider(
                                    create: (context) => WeatherBloc(),
                                    child: WeatherScreen(user: user),
                                  ),
                                  transition: fornavigate.Transition.fadeIn,
                                );
                              },
                              user: user,
                            ),
                          ),
                  );
                }),
                separatorBuilder: ((context, index) => kHeight20),
              );
            }
            if (state is HomeErrorState) {
              return Center(
                child: Text(state.message),
              );
            }

            return const Center(
              child: Text('Something went wrong!'),
            );
          },
        ),
      ),
    );
  }
}
