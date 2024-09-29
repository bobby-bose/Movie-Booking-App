import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/instance_manager.dart';
import 'package:movie_booking_app/controller/location_controller.dart';
import 'package:movie_booking_app/utils/dummy_data.dart';
import 'package:movie_booking_app/utils/mytheme.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  @override
  void initState() {
    super.initState();
    Get.put(LocationController());
  }

  var myLocationWidget = Padding(
    padding: const EdgeInsets.only(top: 20),
    child: GestureDetector(
      onTap: () {
        LocationController.instance.getLocation();
      },
      child: Container(
        decoration: BoxDecoration(
          color: MyTheme.greyColor,
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.all(15),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.my_location, color: Colors.black38),
            SizedBox(
              width: 5,
            ),
            Text(
              "My current Location",
              style: TextStyle(fontSize: 16, color: Colors.black38),
            ),
          ],
        ),
      ),
    ),
  );
  Widget suggestedLocation(String city) => Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black45, width: 1)),
        child: Center(child: Text(city)),
      );
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.splash,
        title: const Text(
          "Select Location",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: LayoutBuilder(builder: (ctx, constraints) {
        return Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              myLocationWidget,
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cities.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: constraints.maxWidth > 600 ? 5 : 3,
                      childAspectRatio: 2.3,
                      crossAxisSpacing: 10,
                      //mainAxisExtent: 0,
                    ),
                    itemBuilder: (_, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              onTap: () {
                                LocationController.instance
                                    .setCity(cities[index]);
                              },
                              child: suggestedLocation(cities[index])),
                        )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Search",
                    prefixIconConstraints:
                        const BoxConstraints(maxHeight: 30, maxWidth: 30),
                    prefix: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SvgPicture.asset(
                        "assets/icons/search.svg",
                        // height: 20,
                        // width: 20,
                        color: Colors.black,
                      ),
                    ),
                    hintStyle: const TextStyle(color: Colors.black45),
                    fillColor: MyTheme.greyColor,
                    filled: true,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
