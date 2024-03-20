import 'package:flutter/material.dart';
import 'package:sky_track/core/colors.dart';
import 'package:sky_track/core/constants.dart';
import 'package:sky_track/domain/weather/models/weather_model.dart';

class CurrentWeatherCard extends StatelessWidget {
  const CurrentWeatherCard({super.key, required this.weather});
  final WeatherModel weather;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          currentTemperatureWidget(),
          kHeight15,
          currentWeatherMoreDetailsWidget(),
        ],
      ),
    );
  }

  Widget currentTemperatureWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          "assets/weather/${weather.weather![0].icon}.png",
          width: 80,
          height: 80,
        ),
        Container(
          height: 45,
          width: 1,
          color: kDividerLineColor,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${weather.main!.temp!.floor()}°",
                style: const TextStyle(
                  color: kBlackColor,
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: "${weather.weather![0].description}",
                style: const TextStyle(
                  color: kSubtitleColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget currentWeatherMoreDetailsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CurrentDeatailIconWidget(icon: "assets/icons/windspeed.png"),
            kHeight05,
            Text(
              "${weather.wind!.speed!.floor()} km/h",
              style: const TextStyle(
                color: kBlackColor,
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CurrentDeatailIconWidget(icon: "assets/icons/clouds.png"),
            kHeight05,
            Text(
              "${weather.clouds!.all}%",
              style: const TextStyle(
                color: kBlackColor,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CurrentDeatailIconWidget(icon: "assets/icons/humidity.png"),
            kHeight05,
            Text(
              "${weather.main!.humidity}%",
              style: const TextStyle(
                color: kBlackColor,
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CurrentDeatailIconWidget extends StatelessWidget {
  const CurrentDeatailIconWidget({super.key, required this.icon});
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Image.asset(icon),
    );
  }
}
