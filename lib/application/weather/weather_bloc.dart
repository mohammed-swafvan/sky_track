import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sky_track/domain/weather/weather_data.dart';
import 'package:sky_track/infastructure/weather/weather_service.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherData? weatherData;

  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeatherEvent>((event, emit) async {
      emit(WeatherLoadingState());
      try {
        // final response = await http.get(
        //   Uri.parse(ApiStrings.apiUrl(event.city)),
        // );

        // final json = jsonDecode(response.body);
        // final double temperature = (json['main']['temp'] - 273 as num).toDouble();

        weatherData = await WeatherService().proccessData(event.city);
        emit(WeatherSucccessState(weatherData: weatherData!));
      } catch (e) {
        log("Weather Error :  ${e.toString()}");
        emit(WeatherErrorState(message: "Failed to fetch weather data for ${event.city}"));
      }
    });
  }
}
