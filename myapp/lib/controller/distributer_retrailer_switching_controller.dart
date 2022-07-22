import 'package:get/get.dart';

class DistributerRetrailerController extends GetxController {
  
  var index = 0.obs;
  
  void clear() {
    index.value = 0;
  }

  void toggle(int value) {
    index.value = value;
  }
  
}
