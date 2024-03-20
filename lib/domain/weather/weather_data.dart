import 'package:sky_track/domain/weather/models/weather_model.dart';

class WeatherData {
  final WeatherModel currentWeather;
  WeatherData(this.currentWeather);

  WeatherModel getCurrentWeather() => currentWeather;
}
