import 'dart:convert';
import 'dart:developer';

import 'package:sky_track/core/api_strings.dart';
import 'package:sky_track/domain/weather/models/weather_model.dart';
import 'package:sky_track/domain/weather/weather_data.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  WeatherData? wheatherData;

  Future<WeatherData> proccessData(String city) async {
    try {
      var response = await http.get(Uri.parse(ApiStrings.apiUrl(city)));
      var jsonBody = jsonDecode(response.body);
      wheatherData = WeatherData(
        WeatherModel.fromJson(jsonBody),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return wheatherData!;
      } else {
        log('Server Failure');
      }
    } catch (e) {
      log('Client Failure --- ${e.toString()}');
      rethrow;
    }
    return wheatherData!;
  }
}
