import 'package:get/get.dart';
import 'package:myapp/controller/distributer_controller.dart';
import 'package:myapp/controller/login_controller.dart';
import 'package:myapp/controller/retrailer_controller.dart';

import '../controller/distributer_retrailer_switching_controller.dart';
import '../controller/pin_location_controller.dart';
import '../controller/product_controller.dart';
import '../controller/search_text_controller.dart';
import '../services/network_connection/network_connection.dart';

class MyBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(
      () => LoginController(),
    );
    Get.lazyPut(
      () => CheckConnectivity(),
    );
    Get.lazyPut(
      () => DistributerController(),
    );
    Get.lazyPut(
      () => RetrailerController(),
    );
    Get.lazyPut(
      () => DistributerRetrailerController(),
    );
    Get.lazyPut(
      () => SearchTextController(),
    );
    Get.lazyPut(
      () => pinlocationController(),
    );
    Get.lazyPut(
      () => ProductController(),
    );
    // Get.lazyPut(
    //   () => SearchTextController(),
    // );
    // Get.lazyPut(
    //   () => QuantityController(),
    // );
    // Get.lazyPut(
    //   () => ChooseAddressController(),
    // );
    // Get.lazyPut(
    //   () => DeliveryTimeController(),
    // );
    // Get.lazyPut(
    //   () => OTPController(),
    // );
  }
}
