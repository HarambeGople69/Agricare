import 'dart:async';
import 'package:intl/intl.dart';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/adapters.dart';

import '../api_services/api_service.dart';
import '../models/attendance_model.dart';
import '../models/login_response_model.dart';
import 'current_location/get_current_location.dart';

class TrackLocation {
   onStart(ServiceInstance service) async {
    print("UTSAV HELLO WORLD");
    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });

      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
    }

    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    // bring to foreground
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      int abc = Hive.box<int>("attendance").get("state")!;
      // if (abc == 0) {
      //   var inputFormat = DateFormat('yyyy-MM-dd HH:mm:s');
      //   String inputDate = inputFormat
      //       .parse(
      //         DateTime.now().toString(),
      //       )
      //       .toString();
      //   String time = inputDate.split(".000")[0];
      //   Position? position;
      //   position = await GetCurrentLocation().getCurrentLocation();
      //   AttendanceModel attendanceModel = AttendanceModel(
      //     mr: Hive.box<loginResponseModel>("userprofileDB")
      //         .get("currentUser")!
      //         .userId
      //         .toString(),
      //     longitude: position!.longitude.toString(),
      //     latitude: position.latitude.toString(),
      //     signal: "",
      //     stamp_time: time,
      //   );
      //   var connectivityResult = await (Connectivity().checkConnectivity());
      //   if (connectivityResult != ConnectivityResult.none) {
      //     await APIService().myattendance(attendanceModel);
      //   } else {
      //     Hive.box<AttendanceModel>("attendanceDB").add(attendanceModel);
      //   }
      //   print("Attendance is being recorded");
      // } else {
      //   print("Attendance is not recorded");
      // }

      if (service is AndroidServiceInstance) {
        service.setForegroundNotificationInfo(
          title: "Your location is being tracked",
          content: "",
        );
      }

      print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
    });
  }
}
