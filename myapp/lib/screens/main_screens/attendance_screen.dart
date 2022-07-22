import 'package:background_location/background_location.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myapp/api_services/api_service.dart';
import 'package:myapp/services/network_connection/network_connection.dart';
import 'package:myapp/utils/utils.dart';
import 'package:myapp/widgets/our_sized_box.dart';
import '../../controller/login_controller.dart';
import '../../models/attendance_model.dart';
import '../../models/login_response_model.dart';
import '../../services/current_location/get_current_location.dart';
import '../../utils/color.dart';
import '../../widgets/our_spinner.dart';
import 'package:intl/intl.dart';

class MyAttendanceScreen extends StatefulWidget {
  const MyAttendanceScreen({Key? key}) : super(key: key);

  @override
  State<MyAttendanceScreen> createState() => _MyAttendanceScreenState();
}

class _MyAttendanceScreenState extends State<MyAttendanceScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // chechNet();
  }

  chechNet() async {
    await CheckConnectivity().checkfirst();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
        inAsyncCall: Get.find<LoginController>().processing.value,
        progressIndicator: OurSpinner(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: darklogoColor,
            title: Text(
              "Attendance",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(25),
                // fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          body: Container(
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setSp(10),
              vertical: ScreenUtil().setSp(10),
            ),
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Attendance Data Sync Status",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(17.5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                OurSizedBox(),
                ValueListenableBuilder(
                  valueListenable:
                      Hive.box<AttendanceModel>("attendanceDB").listenable(),
                  builder: (context, Box<AttendanceModel> boxs, child) {
                    // loginResponseModel loginResponse =
                    //     boxs.get("currentUser")!;
                    var keys = boxs.keys;

                    return keys.isEmpty
                        ? Text(
                            "All synced up",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: ScreenUtil().setSp(17.5),
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : Text(
                            "Not synced up",
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(17.5),
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                  },
                ),
                OurSizedBox(),
                Center(
                  child: Text(
                    "Please choose one of the\nactions below to track your\nattendance",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(17.5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                OurSizedBox(),
                ValueListenableBuilder(
                  valueListenable: Hive.box<int>("attendance").listenable(),
                  builder: (context, Box<int> boxs, child) {
                    int value = boxs.get("state", defaultValue: 1)!;
                    return ElevatedButton(
                      style: ButtonStyle(
                        // backgroundColor: MaterialStateProperty.all(logoColor),
                        elevation: MaterialStateProperty.all(1),
                        backgroundColor: value == 1
                            ? MaterialStateProperty.all(logoColor)
                            : MaterialStateProperty.all(Colors.transparent),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setSp(10),
                            vertical: ScreenUtil().setSp(10),
                          ),
                        ),
                      ),
                      onPressed: value == 1
                          ? () async {
                              final service = FlutterBackgroundService();
                              var isRunning = await service.isRunning();
                              if (isRunning == false) {
                                service.startService();
                              }
                              var inputFormat =
                                  DateFormat('yyyy-MM-dd HH:mm:s');
                              String inputDate = inputFormat
                                  .parse(
                                    DateTime.now().toString(),
                                  )
                                  .toString();
                              String time = inputDate.split(".000")[0];
                              var connectivityResult =
                                  await (Connectivity().checkConnectivity());
                              if (connectivityResult ==
                                  ConnectivityResult.none) {
                                Position? position;
                                position = await GetCurrentLocation()
                                    .getCurrentLocation();
                                AttendanceModel attendanceModel =
                                    AttendanceModel(
                                  mr: Hive.box<loginResponseModel>(
                                          "userprofileDB")
                                      .get("currentUser")!
                                      .userId
                                      .toString(),
                                  longitude: position!.longitude.toString(),
                                  latitude: position.latitude.toString(),
                                  signal: 1.toString(),
                                  stamp_time: time,
                                );
                                // await APIService()
                                //     .myattendance(attendanceModel);
                                var connectivityResult =
                                    await (Connectivity().checkConnectivity());
                                if (connectivityResult !=
                                    ConnectivityResult.none) {
                                  await APIService()
                                      .myattendance(attendanceModel);
                                } else {
                                  Hive.box<AttendanceModel>("attendanceDB")
                                      .add(attendanceModel);
                                }
                                print(Get.find<CheckConnectivity>().isOnline);
                                print("Internet access is not there");

                                Hive.box<int>("attendance").put("state", 0);
                                Hive.box<String>("last_punch_in").put(
                                  "state",
                                  Utils().toDateTime(
                                    DateTime.now(),
                                  ),
                                );
                                // OurToast().showErrorToast("No Internet");
                              } else {
                                print("Internet access is there");
                                Position? position;
                                position = await GetCurrentLocation()
                                    .getCurrentLocation();
                                AttendanceModel attendanceModel =
                                    AttendanceModel(
                                  mr: Hive.box<loginResponseModel>(
                                          "userprofileDB")
                                      .get("currentUser")!
                                      .userId
                                      .toString(),
                                  longitude: position!.longitude.toString(),
                                  latitude: position.latitude.toString(),
                                  signal: 1.toString(),
                                  stamp_time: time,
                                );
                                await APIService()
                                    .myattendance(attendanceModel);

                                Hive.box<int>("attendance").put("state", 0);
                                Hive.box<String>("last_punch_in").put(
                                  "state",
                                  Utils().toDateTime(
                                    DateTime.now(),
                                  ),
                                );
                              }
                            }
                          : null,
                      child: Text(
                        "CONTINUE DAY",
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(15),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: Hive.box<int>("attendance").listenable(),
                  builder: (context, Box<int> boxs, child) {
                    int value = boxs.get("state", defaultValue: 1)!;
                    return ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(1),
                        backgroundColor: value == 0
                            ? MaterialStateProperty.all(logoColor)
                            : MaterialStateProperty.all(Colors.transparent),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setSp(10),
                            vertical: ScreenUtil().setSp(10),
                          ),
                        ),
                      ),
                      onPressed: value == 0
                          ? () async {
                              var connectivityResult =
                                  await (Connectivity().checkConnectivity());
                              if (connectivityResult ==
                                  ConnectivityResult.none) {
                                var inputFormat =
                                    DateFormat('yyyy-MM-dd HH:mm:s');
                                String inputDate = inputFormat
                                    .parse(
                                      DateTime.now().toString(),
                                    )
                                    .toString();
                                String time = inputDate.split(".000")[0];
                                Position? position;
                                position = await GetCurrentLocation()
                                    .getCurrentLocation();
                                Hive.box<AttendanceModel>("attendanceDB")
                                    .add(AttendanceModel(
                                  mr: Hive.box<loginResponseModel>(
                                          "userprofileDB")
                                      .get("currentUser")!
                                      .userId
                                      .toString(),
                                  longitude: position!.longitude.toString(),
                                  latitude: position.latitude.toString(),
                                  signal: 0.toString(),
                                  stamp_time: time,
                                ));
                                // BackgroundLocation.stopLocationService();
                                Hive.box<int>("attendance").put("state", 1);
                                Hive.box<String>("last_punch_out").put(
                                  "state",
                                  Utils().toDateTime(
                                    DateTime.now(),
                                  ),
                                );
                                // OurToast().showErrorToast("No Internet");
                              } else {
                                String currentTime =
                                    Utils().toDateTime(DateTime.now());
                                Position? position;
                                position = await GetCurrentLocation()
                                    .getCurrentLocation();
                                AttendanceModel attendanceModel =
                                    AttendanceModel(
                                  mr: Hive.box<loginResponseModel>(
                                          "userprofileDB")
                                      .get("currentUser")!
                                      .userId
                                      .toString(),
                                  longitude: position!.longitude.toString(),
                                  latitude: position.latitude.toString(),
                                  signal: 0.toString(),
                                  stamp_time: currentTime,
                                );
                                await APIService()
                                    .myattendance(attendanceModel);
                                Hive.box<int>("attendance").put("state", 1);
                                Hive.box<String>("last_punch_out").put(
                                  "state",
                                  Utils().toDateTime(
                                    DateTime.now(),
                                  ),
                                );
                                // }
                              }
                              final service = FlutterBackgroundService();
                              var isRunning = await service.isRunning();
                              if (isRunning) {
                                service.invoke("stopService");
                              }
                            }
                          : null,
                      child: Text(
                        "STOP DAY",
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(15),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                ),
                OurSizedBox(),
                OurSizedBox(),
                Text(
                  "Last Punch-In submitted at:",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(15),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                OurSizedBox(),
                ValueListenableBuilder(
                  valueListenable:
                      Hive.box<String>("last_punch_in").listenable(),
                  builder: (context, Box<String> boxs, child) {
                    String value = boxs.get("state", defaultValue: "")!;
                    return value == ""
                        ? Text(
                            "N/A",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: ScreenUtil().setSp(17.5),
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : Text(
                            value,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: ScreenUtil().setSp(17.5),
                              fontWeight: FontWeight.w600,
                            ),
                          );
                  },
                ),
                OurSizedBox(),
                OurSizedBox(),
                Text(
                  "Last Punch-Out submitted at:",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(15),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                OurSizedBox(),
                ValueListenableBuilder(
                  valueListenable:
                      Hive.box<String>("last_punch_out").listenable(),
                  builder: (context, Box<String> boxs, child) {
                    String value = boxs.get("state", defaultValue: "")!;
                    return value == ""
                        ? Text(
                            "N/A",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: ScreenUtil().setSp(17.5),
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : Text(
                            value,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: ScreenUtil().setSp(17.5),
                              fontWeight: FontWeight.w600,
                            ),
                          );
                  },
                ),
                OurSizedBox(),
                OurSizedBox(),
                Text(
                  "Last CheckIn Type:",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(15),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                OurSizedBox(),
                ValueListenableBuilder(
                  valueListenable: Hive.box<int>("attendance").listenable(),
                  builder: (context, Box<int> boxs, child) {
                    int value = boxs.get("state", defaultValue: 3)!;
                    return value == 3
                        ? Text(
                            "N/A",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: ScreenUtil().setSp(17.5),
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : value == 0
                            ? Text(
                                "Punch In",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: ScreenUtil().setSp(17.5),
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : Text(
                                "Punch Out",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: ScreenUtil().setSp(17.5),
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
