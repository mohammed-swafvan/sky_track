import 'package:flutter/material.dart';
import 'package:sky_track/core/colors.dart';
import 'package:sky_track/core/constants.dart';
import 'package:sky_track/domain/weather/models/weather_model.dart';

class SwitchCardWidget extends StatefulWidget {
  const SwitchCardWidget({super.key, required this.currentWeather});
  final WeatherModel currentWeather;

  @override
  State<SwitchCardWidget> createState() => _SwitchCardWidgetState();
}

class _SwitchCardWidgetState extends State<SwitchCardWidget> {
  bool isSwithed = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16).copyWith(bottom: 0),
                  child: const Text(
                    "Temperature",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: kSubtitleColor,
                    ),
                  ),
                ),
                kHeight05,
                ListTile(
                  title: Text(
                    isSwithed ? "${widget.currentWeather.main!.temp!.floor()}°C" : "--°C",
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
