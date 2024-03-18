import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_track/application/weather/weather_bloc.dart';
import 'package:sky_track/core/colors.dart';
import 'package:sky_track/core/constants.dart';
import 'package:sky_track/domain/user/models/user_model.dart';
import 'package:sky_track/presentation/weather/widgets/user_data_card_widget.dart';
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
  bool isSwithed = false;

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
      header: HeaderWidget(
        onBackButton: () => Navigator.of(context).pop(),
        title: "Weather",
        subtitle: "You can explore user details with the weather here!",
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoadingState || state is WeatherInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is WeatherSucccessState) {
            return Container(
              padding: kEdgeInsetsHoriz16.copyWith(top: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserDataCardWidget(label: "First Name", text: widget.user.firstName),
                  kHeight25,
                  UserDataCardWidget(label: "Last Name", text: widget.user.lastName),
                  kHeight25,
                  UserDataCardWidget(label: "Email Address", text: widget.user.email),
                  kHeight25,
                  UserDataCardWidget(label: "Location", text: widget.user.city),
                  kHeight25,
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Weather",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: kBlackColor,
                        ),
                      ),
                      kHeight05,
                      Material(
                        elevation: 5,
                        shadowColor: kLightGrey,
                        borderRadius: kBorderRadius10,
                        child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: kCardColor,
                            borderRadius: kBorderRadius10,
                          ),
                          child: ListTile(
                            title: Text(
                              isSwithed ? "${state.temperature.floor()}°C" : "--°C",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kBlackColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Switch.adaptive(
                              activeColor: kWhiteColor,
                              activeTrackColor: kPrimaryColor,
                              inactiveThumbColor: kPrimaryColor.withOpacity(0.8),
                              trackOutlineColor: MaterialStateProperty.all<Color>(kPrimaryColor.withOpacity(0.8)),
                              inactiveTrackColor: Colors.transparent,
                              value: isSwithed,
                              onChanged: (val) {
                                setState(() {
                                  isSwithed = val;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
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
    );
  }
}
