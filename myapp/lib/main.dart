import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final documentDirectory = await getApplicationDocumentsDirectory();
  // Hive.init(documentDirectory.path);
  await Hive.initFlutter(documentDirectory.path);
  Hive.registerAdapter(loginResponseModelAdapter());
  Hive.registerAdapter(AttendanceModelAdapter());
  await Hive.openBox<String>(DatabaseHelper.authenticationDB);
  await Hive.openBox<String>("last_punch_in");
  await Hive.openBox<String>("last_punch_out");
  await Hive.openBox<int>("attendance");
  await Hive.openBox<loginResponseModel>("userprofileDB");
  await Hive.openBox<AttendanceModel>("attendanceDB");
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      autoStart: false,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: false,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );

  runApp(MyApp());
}

// Future<void> initializeService() async {
//   await Hive.openBox<int>("attendance");
//   await Hive.openBox<loginResponseModel>("userprofileDB");
//   await Hive.openBox<AttendanceModel>("attendanceDB");
//   final service = FlutterBackgroundService();
//   await service.configure(
//     androidConfiguration: AndroidConfiguration(
//       // this will be executed when app is in foreground or background in separated isolate
//       onStart: onStart,

//       autoStart: false,
//       isForegroundMode: true,
//     ),
//     iosConfiguration: IosConfiguration(
//       autoStart: false,
//       onForeground: onStart,
//       onBackground: onIosBackground,
//     ),
//   );
//   // service.stopSelf();
// }

// to ensure this is executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch
bool onIosBackground(ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();
  print('FLUTTER BACKGROUND FETCH');

  return true;
}

void onStart(ServiceInstance service) async {
  

  

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
  Timer.periodic(const Duration(seconds: 5), (timer) async {
    // int abc = Hive.box<int>("attendance").get("state")!;

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
    //     print("Internet not stored in hive");

    //     await APIService().myattendance(attendanceModel);
    //   } else {
    //     print("No Internet stored in hive");
    //     Hive.box<AttendanceModel>("attendanceDB").add(attendanceModel);
    //   }
    //   print("Attendance is being recorded");
    // } else {
    //   print("Attendance is not recorded");
    // }
    // final hello = preferences.getString("hello");
    // print(hello);

    if (service is AndroidServiceInstance) {
      service.setForegroundNotificationInfo(
        title: "Your location is being tracked",
        content: "",
      );
    }


    print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');

  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
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

// import 'dart:async';
// import 'dart:io';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:workmanager/workmanager.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   Workmanager().initialize(
//       callbackDispatcher, // The top level function, aka callbackDispatcher
//       isInDebugMode:
//           true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
//       );
//   // Workmanager().registerOneOffTask("task-identifier", "simpleTask");
//   runApp(MyApp());
// }

// const simpleTaskKey = "be.tramckrijte.workmanagerExample.simpleTask";
// const rescheduledTaskKey = "be.tramckrijte.workmanagerExample.rescheduledTask";
// const failedTaskKey = "be.tramckrijte.workmanagerExample.failedTask";
// const simpleDelayedTask = "be.tramckrijte.workmanagerExample.simpleDelayedTask";
// const simplePeriodicTask =
//     "be.tramckrijte.workmanagerExample.simplePeriodicTask";
// const simplePeriodic1HourTask =
//     "be.tramckrijte.workmanagerExample.simplePeriodic1HourTask";

// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     switch (task) {
//       case simpleTaskKey:
//         print("$simpleTaskKey was executed. inputData = $inputData");
//         // final prefs = await SharedPreferences.getInstance();
//         // prefs.setBool("test", true);
//         // print("Bool from prefs: ${prefs.getBool("test")}");
//         break;
//       case rescheduledTaskKey:
//         final key = inputData!['key']!;
//         final prefs = await SharedPreferences.getInstance();
//         if (prefs.containsKey('unique-$key')) {
//           print('has been running before, task is successful');
//           return true;
//         } else {
//           await prefs.setBool('unique-$key', true);
//           print('reschedule task');
//           return false;
//         }
//       case failedTaskKey:
//         print('failed task');
//         return Future.error('failed');
//       case simpleDelayedTask:
//         print("$simpleDelayedTask was executed");
//         break;
//       case simplePeriodicTask:
//         print("$simplePeriodicTask was executed");
//         break;
//       case simplePeriodic1HourTask:
//         print("$simplePeriodic1HourTask was executed");
//         break;
//       case Workmanager.iOSBackgroundTask:
//         print("The iOS background fetch was triggered");
//         Directory? tempDir = await getTemporaryDirectory();
//         String? tempPath = tempDir.path;
//         print(
//             "You can access other plugins in the background, for example Directory.getTemporaryDirectory(): $tempPath");
//         break;
//     }

//     return Future.value(true);
//   });
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Flutter WorkManager Example"),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 Text(
//                   "Plugin initialization",
//                   style: Theme.of(context).textTheme.headline5,
//                 ),
//                 ElevatedButton(
//                   child: Text("Start the Flutter background service"),
//                   onPressed: () {
//                     Workmanager().initialize(
//                       callbackDispatcher,
//                       isInDebugMode: true,
//                     );
//                   },
//                 ),
//                 SizedBox(height: 16),

//                 //This task runs once.
//                 //Most likely this will trigger immediately

//                 //This task runs periodically
//                 //It will run about every hour
//                 ElevatedButton(
//                     child: Text("Register 1 hour Periodic Task (Android)"),
//                     onPressed: Platform.isAndroid
//                         ? () {
//                             Workmanager().registerPeriodicTask(
//                               simplePeriodicTask,
//                               simplePeriodic1HourTask,
//                               tag: "ABCDEFGHIJ",
//                               frequency: Duration(minutes: 15),
//                             );
//                           }
//                         : null),
//                 SizedBox(height: 16),
//                 Text(
//                   "Task cancellation",
//                   style: Theme.of(context).textTheme.headline5,
//                 ),
//                 ElevatedButton(
//                   child: Text("Cancel All"),
//                   onPressed: () async {
//                     await Workmanager().cancelAll();
//                     print('Cancel all tasks completed');
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'dart:async';
// import 'dart:io';
// import 'dart:ui';

// // import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await initializeService();
//   runApp(const MyApp());
// }

// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();
//   await service.configure(
//     androidConfiguration: AndroidConfiguration(
//       // this will be executed when app is in foreground or background in separated isolate
//       onStart: onStart,

//       autoStart: false,
//       isForegroundMode: true,
//     ),
//     iosConfiguration: IosConfiguration(
//       autoStart: false,
//       onForeground: onStart,
//       onBackground: onIosBackground,
//     ),
//   );
//   // service.stopSelf();
// }

// // to ensure this is executed
// // run app from xcode, then from xcode menu, select Simulate Background Fetch
// bool onIosBackground(ServiceInstance service) {
//   WidgetsFlutterBinding.ensureInitialized();
//   print('FLUTTER BACKGROUND FETCH');

//   return true;
// }

// void onStart(ServiceInstance service) async {
//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) {
//       service.setAsForegroundService();
//     });

//     service.on('setAsBackground').listen((event) {
//       service.setAsBackgroundService();
//     });
//   }

//   service.on('stopService').listen((event) {
//     service.stopSelf();
//   });

//   // bring to foreground
//   Timer.periodic(const Duration(seconds: 1), (timer) async {
//     print("Utsav Shrestha");
//     // final hello = preferences.getString("hello");
//     // print(hello);

//     if (service is AndroidServiceInstance) {
//       service.setForegroundNotificationInfo(
//         title: "Your location is being tracked",
//         content: "Updated at ${DateTime.now()}",
//       );
//     }

//     print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
//   });
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   String text = "Stop Service";
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Service App'),
//         ),
//         body: Column(
//           children: [
//             ElevatedButton(
//               child: Text(text),
//               onPressed: () async {
//                 final service = FlutterBackgroundService();
//                 var isRunning = await service.isRunning();
//                 if (isRunning) {
//                   service.invoke("stopService");
//                 } else {
//                   service.startService();
//                 }

//                 if (!isRunning) {
//                   text = 'Stop Service';
//                 } else {
//                   text = 'Start Service';
//                 }
//                 setState(() {});
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
