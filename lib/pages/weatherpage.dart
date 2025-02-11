import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/service/weather_service.dart';
class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  //apikey
  final _weatherService = WeatherService();
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    //get city
    String cityName = await _weatherService.getCurrentCity();
    print(cityName);

    //get weather of city
try{
  final weather = await _weatherService.getWeather(cityName);
  setState(() {
    _weather= weather;
  });
}

//any errors
  catch(e){
  print(e);
  }
   }

  //weather animations
String getWeatherAnimation(String? mainCondition){
if(mainCondition == null) return 'assets/sunny.json';

switch (mainCondition.toLowerCase())
    {
  case 'coulds':
  case 'mist':
  case 'smoke':
  case 'haze':
  case 'dust':
  case 'fog':
    return 'assets/cloudy.json';
  case 'rain':
  case 'drizzle':
  case 'showe rain':
    return 'assets/rainy.json';
  case 'thunderstorm':
    return 'assets/thunder.json';
  case 'clear':
    return 'assets/sunny.json';
  default:
    return 'assets/sunny.json';

}



}

  //init state
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //fetch the weather on startup
    _fetchWeather();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          //city name
          Text(_weather?.CityName ?? "Loading City.."),

          //animations
            Lottie.asset('assets/thunder.json'),


          //temperature
          Text('${_weather?.temperature.round()}°C'),


            //get weather condition
            Text(_weather?.mainCondition ?? "")
        ],
        ),
      ),




    );
  }
}
