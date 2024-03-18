part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {}

class FetchWeatherEvent extends WeatherEvent {
  final String city;

  FetchWeatherEvent({required this.city});

  @override
  List<Object?> get props => [city];
}
