import 'dart:convert';


import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService{
  static const Base_URL = 'https://home.openweathermap.org/data/3.0/weather';
  final String apikey = '5adb77541325e8b26ff41b603899fbf3';

  //WeatherService(this.apikey);


  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(Uri.parse('$Base_URL?q=$cityName&appid=$apikey&units=metric'));

    if (response.statusCode == 200)
      {
        return Weather.fromJson(jsonDecode(response.body));
      }
    else
      {
        print(response.statusCode);
        throw Exception('Failed to Load weather data');
      }
  }


  Future<String>getCurrentCity() async {
    //get Permission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission== LocationPermission.denied) {
      print('Denied');
      permission = await Geolocator.requestPermission();
    }
    //fetch the current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high

    );
    print(position);
    //convert the location into a list of placemark
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);


//extract city from the first placemark

  String? city = placemarks[0].locality;
  print(placemarks[0].locality);
  return city ?? "";
  }

}



