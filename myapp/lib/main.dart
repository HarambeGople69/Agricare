import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/screens/splash_screen/splash_screen.dart';
import 'package:myapp/services/current_location/get_current_location.dart';
import 'package:myapp/services/locationTracking.dart';
import 'package:path_provider/path_provider.dart';
import 'api_services/api_service.dart';
import 'app_bindings/my_bindings.dart';
import 'db/db_helper.dart';
import 'models/attendance_model.dart';
import 'models/login_response_model.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import '../../utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:workmanager/workmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:isolate';
import 'package:workmanager/workmanager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(loginResponseModelAdapter());
  Hive.registerAdapter(AttendanceModelAdapter());
  await Hive.openBox<String>(DatabaseHelper.authenticationDB);
  await Hive.openBox<String>("last_punch_in");
  await Hive.openBox<String>("last_punch_out");
  await Hive.openBox<int>("attendance");
  await Hive.openBox<loginResponseModel>("userprofileDB");
  await Hive.openBox<AttendanceModel>("attendanceDB");
  // await initializeService();
  await Workmanager().initialize(callbackDispatcher);
  runApp(MyApp());
}



void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    print("Task executing :" + taskName);
    int attendanceType = Hive.box<int>("attendance").get("state")!;
      if (attendanceType == 0) {
        var inputFormat = DateFormat('yyyy-MM-dd HH:mm:s');
        String inputDate = inputFormat
            .parse(
              DateTime.now().toString(),
            )
            .toString();
        String time = inputDate.split(".000")[0];
        Position? position;
        position = await GetCurrentLocation().getCurrentLocation();
        AttendanceModel attendanceModel = AttendanceModel(
          mr: Hive.box<loginResponseModel>("userprofileDB")
              .get("currentUser")!
              .userId
              .toString(),
          longitude: position!.longitude.toString(),
          latitude: position.latitude.toString(),
          signal: "",
          stamp_time: time,
        );
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult != ConnectivityResult.none) {
          await APIService().myattendance(attendanceModel);
        } else {
          Hive.box<AttendanceModel>("attendanceDB").add(attendanceModel);
        }
        print("Attendance is being recorded");
      } else {
        print("Attendance is not recorded");
      }
    return Future.value(true);
  });
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (child, Widget) {
        return GetMaterialApp(
          title: "Agricare",
          initialBinding: MyBinding(),
          // useInheritedMediaQuery: true,
          builder: (context, widget) {
            // ScreenUtil.setContext(context);
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!);
          },
          home: SplashScreen(),
          debugShowCheckedModeBanner: false,
          // theme: ThemeData.dark(),
          theme: ThemeData(
            scaffoldBackgroundColor: Color(0xffb8cdce),
            // Provider.of<CurrentTheme>(context).darkTheme == false
            //     ? Color.fromARGB(255, 255, 255, 255)
            //     : null,
            // brightness: Provider.of<CurrentTheme>(context).darkTheme
            //     ? Brightness.dark
            //     : Brightness.light,
            // primarySwatch: Colors.amber,
          ),
        );
      },
      // child: LoginScreen(),
    );
  }
}
