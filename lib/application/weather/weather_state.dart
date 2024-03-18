part of 'weather_bloc.dart';

sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherLoadingState extends WeatherState {}

final class WeatherSucccessState extends WeatherState {
  final double temperature;

  WeatherSucccessState({required this.temperature});
}


class WeatherErrorState extends WeatherState {
  final String message;

  WeatherErrorState({required this.message});
}