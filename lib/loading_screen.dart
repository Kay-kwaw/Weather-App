import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:maps_api/models/weathermodel.dart';
import 'dart:convert' as convert;

import 'package:maps_api/waether_screen.dart';


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      getData(position.latitude, position.longitude);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getData(var lat, var lon) async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/3.0/onecall?lat={lat}&lon={lon}&exclude={part}&appid=03bf5532816be7b868c844e9798c2d3e');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;

      // var temperature = convert.jsonDecode(data)['main']['temp'];
      // var cityName = convert.jsonDecode(data)['name'];
      // print(cityName);
      final parsedJson = convert.jsonDecode(data);
      final weather = WeatherApi.fromJson(parsedJson);
      debugPrint('${response.statusCode}');

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => WeatherScreen(
                  weather.temperature, weather.name, WeatherApi: weather
              )),
          (route) => false);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      ),
    );
  }
}
