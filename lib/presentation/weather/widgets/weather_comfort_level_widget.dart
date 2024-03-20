import 'package:flutter/material.dart';
import 'package:sky_track/core/colors.dart';
import 'package:sky_track/core/constants.dart';
import 'package:sky_track/domain/weather/models/weather_model.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class WeatherComfortLevelWidget extends StatelessWidget {
  const WeatherComfortLevelWidget({super.key, required this.weather});

  final WeatherModel weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Comfort Level",
          style: TextStyle(
            color: kBlackColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        kHeight20,
        SleekCircularSlider(
          initialValue: weather.main!.humidity!.toDouble(),
          min: 0,
          max: 100,
          appearance: CircularSliderAppearance(
            animationEnabled: true,
            infoProperties: InfoProperties(
              bottomLabelText: 'Humidity',
              bottomLabelStyle: const TextStyle(
                color: kBlackColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.1,
                height: 1.8,
              ),
            ),
            size: 140,
            customWidths: CustomSliderWidths(
              handlerSize: 0,
              trackWidth: 12,
              progressBarWidth: 13,
            ),
            customColors: CustomSliderColors(
              hideShadow: true,
              trackColor: kFirstGradientColor.withAlpha(80),
              progressBarColors: [
                kFirstGradientColor,
                kSecondGradientColor,
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 20,
              width: 1,
              color: kDividerLineColor,
            ),
            kWidth15,
            Text(
              "Feels Like ${weather.main!.feelsLike}",
              style: const TextStyle(
                color: kBlackColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            kWidth15,
            Container(
              height: 20,
              width: 1,
              color: kDividerLineColor,
            ),
          ],
        ),
      ],
    );
  }
}
