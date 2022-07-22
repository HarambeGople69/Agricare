import 'package:get/get.dart';

class ProductController extends GetxController{
  RxList<String> productNameList = [""].obs;
  RxList<String> productIDList = [""].obs;

   void addproductnamelist(List<String> data) {
    print("Inside Distribuler Controller");
    print("-==============");
    print("-==============");
    print("-==============");
    print(data);
    productNameList.value = [];
    productNameList.value = data;
  }

  void addproductIDlist(List<String> data) {
    productIDList.value = [];
    productIDList.value = data;
  }


}