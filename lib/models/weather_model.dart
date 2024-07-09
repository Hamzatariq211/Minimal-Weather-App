class Weather {
  final String CityName;
  final double temperature;
  final String condition;

  Weather({
    required this.CityName,
    required this.temperature,
    required this.condition,
});
  factory Weather.fromJson(Map<String,dynamic>json) {
    return Weather(
      CityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      condition: json['weather'][0]['main']

    );
  }

}