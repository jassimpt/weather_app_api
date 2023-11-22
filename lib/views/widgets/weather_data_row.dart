import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wheather_app/views/screens/homescreen.dart';

class WeatherInfo extends StatelessWidget {
  String image;
  String image2;
  String text1;
  String text2;
  double? gap;
  String? data1;
  String? data2;
  double? imgh1;
  double? imgw1;

  WeatherInfo({
    super.key,
    required this.text1,
    required this.text2,
    required this.image,
    required this.image2,
    required this.gap,
    required this.data1,
    required this.data2,
    required this.imgh1,
    required this.imgw1,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          image,
          height: imgh1, //60
          width: imgw1,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text1,
              style: GoogleFonts.kanit(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            data1 != null
                ? Text(
                    data1!,
                    style: GoogleFonts.kanit(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                : spinKit()
          ],
        ),
        SizedBox(
          width: gap,
        ),
        Image.asset(
          image2,
          height: imgh1,
          width: imgw1,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text2,
              style: GoogleFonts.kanit(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            data2 != null
                ? Text(
                    data2!,
                    style: GoogleFonts.kanit(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                : spinKit()
          ],
        ),
      ],
    );
  }
}
