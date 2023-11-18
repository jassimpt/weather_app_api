import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wheather_app/services/location_provider.dart';
import 'package:wheather_app/services/weather_service_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final locationprov = Provider.of<LocationProvider>(context, listen: false);
    locationprov.positionFinder().then((_) {
      if (locationprov.currentLocationName != null) {
        var city = locationprov.currentLocationName!.locality;
        if (city != null) {
          Provider.of<WeatherServiceProvider>(context, listen: false)
              .getWeatherByCity(city);
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final weatherpro =
        Provider.of<WeatherServiceProvider>(context, listen: false);

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/clouds.jpg'), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40, top: 80),
          child: Consumer2<LocationProvider, WeatherServiceProvider>(
            builder: (context, location, weather, child) {
              String locationArea;
              if (location.currentLocationName == null) {
                locationArea = 'Unknown';
              } else {
                locationArea = location.currentLocationName!.locality!;
              }

              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: weather.citycontroller,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            hintText: 'Search Your City',
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            weather.citySearch();
                          },
                          icon: const Icon(
                            Icons.search,
                            size: 35,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            locationArea,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Oct 10 2023 7:30 PM',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Image.asset('assets/img/snow.png'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${weatherpro.weather?.main?.temp.toString()} ° C",
                    style: GoogleFonts.kanit(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    weatherpro.weather?.weather?[0].main.toString() ?? 'N/A',
                    style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat("hh:mm a").format(DateTime.now()),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/img/temperature-high.png',
                        height: 60,
                        width: 60,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Temp Max',
                            style: GoogleFonts.kanit(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${weatherpro.weather?.main?.tempMax} ° C",
                            style: GoogleFonts.kanit(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Image.asset(
                        'assets/img/temperature-low.png',
                        height: 60,
                        width: 60,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Temp Min',
                            style: GoogleFonts.kanit(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${weatherpro.weather?.main?.tempMin} ° C",
                            style: GoogleFonts.kanit(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.white,
                    thickness: 2,
                    indent: 15,
                    endIndent: 15,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/img/sun.png',
                        height: 60,
                        width: 60,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sunrise',
                            style: GoogleFonts.kanit(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '21 ° C',
                            style: GoogleFonts.kanit(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      Image.asset(
                        'assets/img/moon.png',
                        height: 50,
                        width: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Moon',
                            style: GoogleFonts.kanit(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '04 ° C',
                            style: GoogleFonts.kanit(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
