import 'package:flutter/material.dart';
import 'package:movie_booking_app/utils/dummy_data.dart';

class CustomSlide extends StatelessWidget {
  final index;
  const CustomSlide({super.key, this.index = 0});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.3,
      width: size.width,
      child: Image.asset(
        sliderData[index].url,
        fit: BoxFit.cover,
      ),
    );
  }
}
