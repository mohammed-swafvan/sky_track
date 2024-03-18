import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:sky_track/core/api_strings.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeatherEvent>((event, emit) async {
      emit(WeatherLoadingState());
      try {
        final response = await http.get(
          Uri.parse(ApiStrings.apiUrl(event.city)),
        );

        final json = jsonDecode(response.body);
        final double temperature = (json['main']['temp'] - 273 as num).toDouble();
        emit(WeatherSucccessState(temperature: temperature));
      } catch (e) {
        log("Weather Error :  ${e.toString()}");
        emit(WeatherErrorState(message: "Failed to fetch weather data for ${event.city}"));
      }
    });
  }
}
