import 'package:get/state_manager.dart';

class DistributerController extends GetxController {
  RxList<String> distnameList = [""].obs;
  RxList<String> distIDList = [""].obs;

  void adddistnamelist(List<String> data) {
    print("Inside Distribuler Controller");
    print("-==============");
    print("-==============");
    print("-==============");
    print(data);
    distnameList.value = [];
    distnameList.value = data;
  }

  void adddistIDlist(List<String> data) {
    distIDList.value = [];
    distIDList.value = data;
  }
}
