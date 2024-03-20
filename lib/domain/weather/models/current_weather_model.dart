

// class CurrentWeatherModel {
//   final CurrentModel currentModel;
//   CurrentWeatherModel({required this.currentModel});

//   factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) =>
//       CurrentWeatherModel(currentModel: CurrentModel.fromJson(json["current"]));
// }

// class CurrentModel {
//   double? temp;
//   double? uvi;
//   double? feelsLike;
//   int? humidity;
//   int? clouds;
//   double? windSpeed;
//   int? visibility;

//   CurrentModel({
//     this.temp,
//     this.uvi,
//     this.feelsLike,
//     this.humidity,
//     this.clouds,
//     this.windSpeed,
//     this.visibility,
//   });

//   factory CurrentModel.fromJson(Map<String, dynamic> json) => CurrentModel(
//         temp: (json['temp'] as num?)?.toDouble(),
//         uvi: (json['uvi'] as num?)?.toDouble(),
//         feelsLike: (json['feels_like'] as num?)?.toDouble(),
//         humidity: json['humidity'] as int?,
//         clouds: json['clouds'] as int?,
//         windSpeed: (json['wind_speed'] as num?)?.toDouble(),
//         visibility: json['visibility'] as int?,
//       );

//   Map<String, dynamic> toJson() => {
//         'temp': temp,
//         'humidity': humidity,
//         'clouds': clouds,
//         'wind_speed': windSpeed,
//         'visibility': visibility,
//         'feels_like': feelsLike,
//         'uvi': uvi,
//       };
// }