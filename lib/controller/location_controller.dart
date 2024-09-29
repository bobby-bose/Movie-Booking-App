import 'package:geocoding/geocoding.dart' as geo;
import 'package:get/get.dart';

import 'package:location/location.dart';
import 'package:movie_booking_app/utils/dummy_data.dart';

class LocationController extends GetxController {
  late RxString city = cities[0].obs;
  RxBool isLocation = false.obs;
  static LocationController instance = Get.find();
  @override
  void onReady() {
    super.onReady();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    //getting current location
    _locationData = await location.getLocation();

    var address =
        await geo.GeocodingPlatform.instance!.placemarkFromCoordinates(
      _locationData.latitude!,
      _locationData.longitude!,
    );
    print(address[0].subLocality);
    setCity(address[0].locality!);
  }

  setCity(String myCity) {
    city = myCity.obs;
    update();
  }
}
