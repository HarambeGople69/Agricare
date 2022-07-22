import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/api_services/api_service.dart';
import 'package:myapp/models/attendance_model.dart';

class CheckConnectivity extends GetxController {
  var isOnline = false.obs;
  void initialize() {
    Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        print("Connection Checking mode enabled");
        // Got a new connectivity status!
        if (result == ConnectivityResult.none) {
          print("No network");
          isOnline = false.obs;
          print("=========");
          print("+++++++");
          print(isOnline);
          print("=========");
          print("+++++++");
        } else if (result == ConnectivityResult.mobile ||
            result == ConnectivityResult.wifi) {
          isOnline = true.obs;
          print("There is  network");
          print("Hello Utsav");
          print("=========");
          print("+++++++");
          print(isOnline);
          print("=========");
          print("+++++++");
          print("Hello Utkrista");
          print("Hello Usha");
          try {
            var keyss = Hive.box<AttendanceModel>("attendanceDB").keys;
            print(keyss);
            keyss.forEach((element) async {
              await APIService().myattendance(
                  Hive.box<AttendanceModel>("attendanceDB").get(element)!);
              try {
                await Hive.box<AttendanceModel>("attendanceDB").delete(element);
              } catch (e) {
                print(e);
              }
            });
          } catch (e) {
            print(e);
          }
        }
      },
    );
  }
  checkfirst() async {
    print("Inside checkfirst");
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("NO NET");
      isOnline.value = false;
    } else {
      isOnline.value = true;
      print("NET");

      // I am connected to a wifi network.
    }
  }
}
