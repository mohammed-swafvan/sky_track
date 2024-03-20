import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as fornavigate;
import 'package:sky_track/application/sign_in/sign_in_bloc.dart';
import 'package:sky_track/application/weather/weather_bloc.dart';
import 'package:sky_track/core/constants.dart';
import 'package:sky_track/domain/user/models/user_model.dart';
import 'package:sky_track/presentation/utils/alert_dialog_uilts.dart';
import 'package:sky_track/presentation/weather/widgets/current_weather_card.dart';
import 'package:sky_track/presentation/weather/widgets/switch_card_widget.dart';
import 'package:sky_track/presentation/weather/widgets/user_data_card_widget.dart';
import 'package:sky_track/presentation/weather/widgets/weather_comfort_level_widget.dart';
import 'package:sky_track/presentation/welcome/welcome_screen.dart';
import 'package:sky_track/presentation/widgets/custom_scaffold.dart';
import 'package:sky_track/presentation/widgets/header_widget.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key, required this.user});
  final UserModel user;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late WeatherBloc weatherBloc;

  @override
  void initState() {
    weatherBloc = context.read<WeatherBloc>();
    fetchWeatherData();
    super.initState();
  }

  void fetchWeatherData() {
    weatherBloc.add(FetchWeatherEvent(city: widget.user.city));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      header: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignOutSuccess) {
            fornavigate.Get.off(
              () => const WelcomeScreen(),
            );
          }
        },
        child: HeaderWidget(
          onBackButton: () => Navigator.of(context).pop(),
          onLogOut: () {
            AlertDialoqUtils.customAlertDialoque(
              context: context,
              onTap: () {
                context.read<SignInBloc>().add(
                      const SignOutRequired(),
                    );
              },
              title: "Sign Out",
              content: "Are you sure you want to sign out",
            );
          },
          title: "Weather",
          subtitle: "You can explore user details with the weather here!",
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          fetchWeatherData();
        },
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoadingState || state is WeatherInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is WeatherSucccessState) {
              return Container(
                padding: kEdgeInsetsHoriz16,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CurrentWeatherCard(weather: state.weatherData.getCurrentWeather()),
                      kHeight25,
                      Row(
                        children: [
                          Expanded(
                            child: UserDataCardWidget(
                              label: "Full Name",
                              text: "${widget.user.firstName} ${widget.user.lastName}",
                            ),
                          ),
                          kWidth10,
                          Expanded(
                            child: UserDataCardWidget(
                              label: "Address",
                              text: widget.user.email,
                              city: widget.user.city,
                            ),
                          ),
                        ],
                      ),
                      kHeight25,
                      SwitchCardWidget(currentWeather: state.weatherData.getCurrentWeather()),
                      kHeight25,
                      WeatherComfortLevelWidget(weather: state.weatherData.getCurrentWeather()),
                      kHeight25,
                    ],
                  ),
                ),
              );
            }
            if (state is WeatherErrorState) {
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
