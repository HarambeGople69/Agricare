import 'package:get/get.dart';

class RetrailerController extends GetxController{
  RxList<String> retrailernameList = [""].obs;
  RxList<String> retrailerIDList = [""].obs;

  void addretrailernamelist(List<String> data) {
    print("Inside retrailer Controller");
    print("-==============");
    print("-==============");
    print("-==============");
    print(data);
    retrailernameList.value = [];
    retrailernameList.value = data;
  }

  void addretrailerIDlist(List<String> data) {
    retrailerIDList.value = [];
    retrailerIDList.value = data;
  }
}