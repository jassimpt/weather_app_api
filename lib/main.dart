import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheather_app/services/location_provider.dart';
import 'package:wheather_app/services/weather_service_provider.dart';
import 'package:wheather_app/views/screens/homescreen.dart';

void main(List<String> args) {
  runApp(const myapp());
}

class myapp extends StatelessWidget {
  const myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LocationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WeatherServiceProvider(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
