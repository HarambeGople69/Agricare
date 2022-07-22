import 'package:get/get.dart';

class pinlocationController extends GetxController {
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  void updateLocation(double latitudeValue, double longitudeValue) {
    latitude.value = latitudeValue;
    longitude.value = longitudeValue;
  }

  void clearData() {
    latitude.value = 0.0;
    longitude.value = 0.0;
  }
}
