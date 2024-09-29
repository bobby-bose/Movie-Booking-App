import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movie_booking_app/controller/auth_controller.dart';
import 'package:movie_booking_app/controller/location_controller.dart';
import 'package:movie_booking_app/pages/profile_screen.dart';
import 'package:movie_booking_app/pages/select_location.dart';
import 'package:movie_booking_app/utils/constants.dart';
import 'package:movie_booking_app/utils/custom_slide.dart';
import 'package:movie_booking_app/utils/dummy_data.dart';
import 'package:movie_booking_app/utils/event_items.dart';
import 'package:movie_booking_app/utils/manu_item.dart';
import 'package:movie_booking_app/utils/movie_item.dart';
import 'package:movie_booking_app/utils/mytheme.dart';
import 'package:movie_booking_app/utils/plays_items.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String city = cities[0];
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: MyTheme.statusBar,
    ));
    String? picUrl = AuthController.instance.user!.photoURL;
    picUrl = picUrl ?? Constants.dummyAvatar;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false, ////////////
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => const ProfileScreen());
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: picUrl,
                      height: 55,
                      width: 55,
                    )),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AuthController.instance.user!.displayName ?? "Name",
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        Get.to(() => const SelectLocationScreen());
                      },
                      child: Row(
                        children: [
                          Text(
                            LocationController.instance.city.value,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                inherit: true,
                                fontSize: 17),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white.withOpacity(0.7),
                          )
                        ],
                      ),
                    ),
                  ),
                  // DropdownButton<String>(
                  //     value: city,
                  //     dropdownColor: MyTheme.statusBar,
                  //     isDense: true,
                  //     icon: Icon(
                  //       Icons.keyboard_arrow_down,
                  //       color: Colors.white.withOpacity(0.7),
                  //     ),
                  //     items: cities
                  //         .map(
                  //           (e) => DropdownMenuItem<String>(
                  //             value: e,
                  //             child: Text(e),
                  //           ),
                  //         )
                  //         .toList(),
                  //     onChanged: (st) {
                  //       setState(() {
                  //         city = st!;
                  //       });
                  //     })
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset("assets/icons/search.svg"),
              ),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset("assets/icons/notification.svg"),
              ),
            ],
          ),
        ),
        body: Container(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            // physics: const BouncingScrollPhysics(
            //   parent: AlwaysScrollableScrollPhysics(),
            // ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.height * 0.2,
                  width: size.width,
                  color: Colors.red,
                  child: PageView.builder(
                      itemCount: 3,
                      itemBuilder: (_, i) {
                        return CustomSlide(
                          index: i,
                        );
                      }),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 20),
                  child: Text(
                    "SEAT CATEGORIES",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                const MenuItem(),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 20),
                  child: Text(
                    "RECOMMENDED SEATS",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                const MoviesItems(),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 10, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Nearby theatres".toUpperCase(),
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "View all",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: MyTheme.splash),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: size.height * 0.2,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer(),
                      )
                    },
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    zoomControlsEnabled: false,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 10, right: 20),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/spotlights.svg",
                        color: Colors.black.withOpacity(0.8),
                        height: 18,
                        width: 18,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Events".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "View all",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: MyTheme.splash),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const EventItems(),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 10, right: 20),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/theater_masks.svg",
                        color: Colors.black.withOpacity(0.8),
                        height: 18,
                        width: 18,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Plays".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "View all",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: MyTheme.splash),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const PlaysItems(), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}
