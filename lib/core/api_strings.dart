class ApiStrings {
  static const String apiKey = "de1339d538e1bcc1179fd796ee07cc4b";
  static String apiUrl(String city) {
    String url;
    url = "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey";
    return url;
  }
}
