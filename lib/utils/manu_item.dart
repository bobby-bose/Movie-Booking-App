import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_booking_app/utils/dummy_data.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.12,
      width: size.width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: menus.length,
          itemBuilder: (_, i) {
            return Padding(
              padding: const EdgeInsets.only(top: 10, left: 10.0, right: 20),
              child: GestureDetector(
                onTap: () {
                  print(menus[i].name);
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        menus[i].asset,
                        height: 40,
                        width: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      menus[i].name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.7)),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
