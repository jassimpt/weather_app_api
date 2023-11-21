import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wheather_app/models/weather_model.dart';
import 'package:wheather_app/secrets/api.dart';
import 'package:http/http.dart' as http;

class WeatherServiceProvider extends ChangeNotifier {
  WeatherModel? weather;
  String? locationArea;
  bool isloading = false;
  String error = '';
  TextEditingController citycontroller = TextEditingController();
  Future<void> getWeatherByCity(String city) async {
    error = '';
    try {
      final cityurl =
          "${ApiEndPoints().cityurl}${city}&appid=${ApiEndPoints().key}${ApiEndPoints().unit}";
      final response = await http.get(Uri.parse(cityurl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        weather = WeatherModel.fromJson(data);
        notifyListeners();
      } else {
        error = 'No data';
      }
    } catch (e) {
      error = 'Failed to load data';
      notifyListeners();
    }
  }

  citySearch() async {
    getWeatherByCity(citycontroller.text);
    locationArea = citycontroller.text;

    notifyListeners();
  }
}
