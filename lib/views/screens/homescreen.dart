import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wheather_app/services/location_provider.dart';
import 'package:wheather_app/services/weather_service_provider.dart';
import 'package:wheather_app/views/widgets/weather_data_row.dart';

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
    bool clicked = false;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/img/clouds.jpg'),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 80),
            child: Consumer2<LocationProvider, WeatherServiceProvider>(
              builder: (context, location, weather, child) {
                String? locationArea;

                if (location.currentLocationName == null) {
                  weather.locationArea = 'Unknown';
                } else if (clicked == true) {
                  locationArea = weather.locationArea!;
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
                              clicked = true;
                            },
                            icon: const Icon(
                              Icons.search,
                              size: 35,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        locationArea != null
                            ? Text(
                                locationArea,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            : spinKit(),
                        const SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Image.asset('assets/img/clouds.png'),
                    const SizedBox(
                      height: 20,
                    ),
                    weather.weather?.main?.temp != null
                        ? Text(
                            "${weather.weather!.main!.temp.toString()} ° C",
                            style: GoogleFonts.kanit(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          )
                        : spinKit(),
                    weather.weather?.weather?[0].main != null
                        ? Text(
                            "${weather.weather!.weather![0].main.toString()} ",
                            style: GoogleFonts.ubuntu(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                        : spinKit(),
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
                    WeatherInfo(
                      imgh1: 60,
                      imgw1: 60,
                      image: 'assets/img/temperature-high.png',
                      text1: 'Temp Max',
                      image2: 'assets/img/temperature-low.png',
                      text2: 'Temp Min',
                      gap: 30,
                      data1: "${weather.weather?.main?.tempMax} ° C",
                      data2: "${weather.weather?.main?.tempMin} ° C",
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 2,
                      indent: 15,
                      endIndent: 15,
                    ),
                    WeatherInfo(
                      imgh1: 50,
                      imgw1: 50,
                      image: "assets/img/humidity.png",
                      text1: 'Humidity',
                      image2: 'assets/img/pressure.png',
                      gap: 60,
                      text2: 'Pressure',
                      data1: weather.weather?.main?.humidity.toString(),
                      data2: weather.weather?.main?.pressure.toString(),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

SpinKitFadingFour spinKit() {
  return const SpinKitFadingFour(
    size: 20,
    color: Colors.white,
  );
}
