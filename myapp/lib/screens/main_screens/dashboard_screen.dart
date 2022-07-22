import 'dart:async';
import 'package:background_location/background_location.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:myapp/api_services/api_service.dart';
import 'package:myapp/controller/login_controller.dart';
import 'package:myapp/controller/pin_location_controller.dart';
import 'package:myapp/db/db_helper.dart';
import 'package:myapp/screens/main_screens/attendance_screen.dart';
import 'package:myapp/screens/main_screens/distributer_order_load_screen.dart';
import 'package:myapp/screens/main_screens/distributor_relation_screen..dart';
import 'package:myapp/screens/main_screens/distributor_stoke_screen.dart';
import 'package:myapp/screens/main_screens/map_location_screen.dart';
import 'package:myapp/screens/main_screens/retailer_order_load_screen.dart';
import 'package:myapp/screens/main_screens/tada_screen.dart';
import 'package:myapp/screens/main_screens/visit_plan_screen.dart';
import 'package:myapp/utils/color.dart';
import 'package:myapp/widgets/our_dashboard_screen.dart';
import 'package:myapp/widgets/our_drawer.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import 'package:myapp/widgets/our_sized_box.dart';
import 'package:page_transition/page_transition.dart';
import '../../controller/distributer_controller.dart';
import '../../controller/retrailer_controller.dart';
import '../../models/attendance_model.dart';
import '../../models/login_response_model.dart';
import '../../services/current_location/get_current_location.dart';
import '../../services/network_connection/network_connection.dart';
import '../../utils/utils.dart';
import '../../widgets/our_flutter_toast.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late Timer timer;
  TextEditingController date_controller = TextEditingController();
  DateTime dateoftravel = DateTime.now();
  final item = [
    "Distributer",
    "Retailers",
  ];
  TextEditingController lat_controller = TextEditingController();
  TextEditingController long_controller = TextEditingController();
  String? partyDistributerName;
  String partyDistributerId = "TEST";
  String? partyRetrailerName;
  String partyRetrailerId = "TEST";
  String? value;
  String travellerForId = "1";
  bool showdistributer = true;
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Center(
          child: Text(
            item,
            style: TextStyle(
              color: logoColor,
              fontSize: ScreenUtil().setSp(
                17.5,
              ),
            ),
          ),
        ),
      );
  Position? position;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    CheckConnectivity().initialize();
    setState(() {
      date_controller.text =
          "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}";
    });
    fetchData();
  }

  void openBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffb8cdce),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setSp(15),
                  vertical: ScreenUtil().setSp(10),
                ),
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                height: MediaQuery.of(context).size.height * 0.75,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                "PIN location",
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(20.5),
                                  color: darklogoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.close,
                                color: darklogoColor,
                                size: ScreenUtil().setSp(27.5)),
                          ),
                        ],
                      ),
                      Divider(
                        color: logoColor,
                      ),
                      OurSizedBox(),
                      Row(
                        children: [
                          Text(
                            "Date of travel:",
                            style: TextStyle(
                              color: darklogoColor,
                              fontSize: ScreenUtil().setSp(17.5),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().setSp(10),
                          ),
                          Expanded(
                            child: TextField(
                              onTap: () async {
                                late DateTime dateTime;
                                DateTime initialTime = DateTime.now();
                                DateTime? date = await showDatePicker(
                                  context: context,
                                  // helpText:"Help",
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2200),
                                );
                                if (date == null) {
                                  return null;
                                }

                                setState(() {
                                  dateTime = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                  );
                                  print(dateTime);
                                  dateoftravel = dateTime;
                                  date_controller.text =
                                      "${dateTime.year}/${dateTime.month}/${dateTime.day}";
                                  print(date_controller);
                                });
                              },
                              readOnly: true,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(17),
                                color: logoColor,
                              ),
                              controller: date_controller,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText:
                                    "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}",
                              ),
                            ),
                          ),
                        ],
                      ),
                      OurSizedBox(),
                      Text(
                        "Travelling for:",
                        style: TextStyle(
                          color: darklogoColor,
                          fontSize: ScreenUtil().setSp(17.5),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      OurSizedBox(),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey[500]!,
                            ),
                            borderRadius: BorderRadius.circular(
                              ScreenUtil().setSp(15),
                            )),
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setSp(5),
                          vertical: ScreenUtil().setSp(5),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isDense: true,
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            isExpanded: true,
                            hint: Center(
                              child: Text(
                                "Distributer",
                                style: TextStyle(
                                  color: logoColor,
                                  fontSize: ScreenUtil().setSp(
                                    17.5,
                                  ),
                                ),
                              ),
                            ),
                            value: value,
                            onChanged: (value) => setState(() {
                              if (value == "Distributer") {
                                travellerForId = "1";
                                print(travellerForId);
                                showdistributer = true;
                              } else {
                                travellerForId = "2";
                                print(travellerForId);

                                showdistributer = false;
                              }
                              this.value = value;
                            }),
                            items: item.map(buildMenuItem).toList(),
                          ),
                        ),
                      ),
                      OurSizedBox(),
                      Text(
                        "Party:",
                        style: TextStyle(
                          color: darklogoColor,
                          fontSize: ScreenUtil().setSp(17.5),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      OurSizedBox(),
                      showdistributer == true
                          ? Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey[500]!,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    ScreenUtil().setSp(15),
                                  )),
                              padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setSp(5),
                                vertical: ScreenUtil().setSp(5),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isDense: true,
                                  borderRadius: BorderRadius.circular(
                                    15,
                                  ),
                                  isExpanded: true,
                                  hint: Center(
                                    child: Text(
                                      "Party",
                                      style: TextStyle(
                                        color: logoColor,
                                        fontSize: ScreenUtil().setSp(
                                          17.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                  value: partyDistributerName,
                                  onChanged: (value) => setState(() {
                                    this.partyDistributerName = value;
                                    int index =
                                        Get.find<DistributerController>()
                                            .distnameList
                                            .indexOf(value);
                                    print(index);
                                    String id =
                                        Get.find<DistributerController>()
                                            .distIDList[index];
                                    partyDistributerId = id;
                                    print("Utsav");
                                    print(id);
                                    print("Utkrista");
                                  }),
                                  items: Get.find<DistributerController>()
                                      .distnameList
                                      .map(buildMenuItem)
                                      .toList(),
                                ),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey[500]!,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    ScreenUtil().setSp(15),
                                  )),
                              padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setSp(5),
                                vertical: ScreenUtil().setSp(5),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isDense: true,
                                  borderRadius: BorderRadius.circular(
                                    15,
                                  ),
                                  isExpanded: true,
                                  hint: Center(
                                    child: Text(
                                      "Party",
                                      style: TextStyle(
                                        color: logoColor,
                                        fontSize: ScreenUtil().setSp(
                                          17.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                  value: partyRetrailerName,
                                  onChanged: (value) => setState(() {
                                    this.partyRetrailerName = value;
                                    int index = Get.find<RetrailerController>()
                                        .retrailernameList
                                        .indexOf(value);
                                    print(index);
                                    String id = Get.find<RetrailerController>()
                                        .retrailerIDList[index];

                                    partyRetrailerId = id;
                                    print("Utsav");
                                    print(id);
                                    print("Utkrista");
                                  }),
                                  items: Get.find<RetrailerController>()
                                      .retrailernameList
                                      .map(buildMenuItem)
                                      .toList(),
                                ),
                              ),
                            ),
                      OurSizedBox(),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Location:",
                              style: TextStyle(
                                color: darklogoColor,
                                fontSize: ScreenUtil().setSp(17.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: InkWell(
                              onTap: () async {
                                position = await GetCurrentLocation()
                                    .getCurrentLocation();

                                Get.find<LoginController>().toggle(false);
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: ShopMapScreen(
                                      pinWidget: Icon(
                                        Icons.location_pin,
                                        color: Colors.red,
                                        size: ScreenUtil().setSp(50),
                                      ),
                                      pinColor: Colors.blue,
                                      // context: context,
                                      addressPlaceHolder: "Loading",
                                      addressTitle: "Address",
                                      apiKey:
                                          "AIzaSyDp0lkk5V0XgNCih8NG3TXNxbZU6_vR7A8",
                                      appBarTitle: "Select PIN address",
                                      confirmButtonColor: logoColor,
                                      confirmButtonText: "Done",
                                      confirmButtonTextColor: Colors.white,
                                      country: "NP",
                                      language: "en",
                                      searchHint: "Search",
                                      initialLocation: LatLng(
                                        position!.latitude,
                                        position!.longitude,
                                      ),
                                    ),
                                    type: PageTransitionType.leftToRight,
                                  ),
                                ).then((value) {
                                  if (Get.find<pinlocationController>()
                                              .latitude
                                              .value !=
                                          0.0 ||
                                      Get.find<pinlocationController>()
                                              .longitude
                                              .value !=
                                          0.0) {
                                    print("Hello world");
                                    setState(() {
                                      lat_controller.text =
                                          Get.find<pinlocationController>()
                                              .latitude
                                              .value
                                              .toString();
                                      long_controller.text =
                                          Get.find<pinlocationController>()
                                              .longitude
                                              .value
                                              .toString();
                                    });
                                  } else {
                                    print("Hello world 2");
                                  }
                                });
                              },
                              child: Text(
                                "Select Location",
                                style: TextStyle(
                                  color: Colors.red.withOpacity(0.75),
                                  fontSize: ScreenUtil().setSp(18.5),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      OurSizedBox(),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Latitude:",
                                  style: TextStyle(
                                    color: darklogoColor,
                                    fontSize: ScreenUtil().setSp(17.5),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setSp(5),
                                ),
                                TextField(
                                  readOnly: true,
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(17),
                                    color: logoColor,
                                  ),
                                  controller: lat_controller,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "Latitude",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().setSp(15),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Longitude:",
                                  style: TextStyle(
                                    color: darklogoColor,
                                    fontSize: ScreenUtil().setSp(17.5),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setSp(5),
                                ),
                                TextField(
                                  readOnly: true,
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(17),
                                    color: logoColor,
                                  ),
                                  controller: long_controller,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "Longitude",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      OurSizedBox(),
                      Center(
                        child: OurElevatedButton(
                          title: "Submit",
                          function: () async {
                            var inputFormat = DateFormat('yyyy-MM-dd HH:mm:s');
                            String inputDate = inputFormat
                                .parse(
                                  DateTime.now().toString(),
                                )
                                .toString();
                            String time = inputDate.split(".000")[0];
                            Map<String, String> toJson = {
                              "longitude": long_controller.text,
                              "latitude": lat_controller.text,
                              "pin_time": time,
                              "location_type": travellerForId,
                              "entity_id": travellerForId == "1"
                                  ? partyDistributerId
                                  : partyRetrailerId,
                            };
                            print(toJson);

                            if (travellerForId == "1") {
                              if (lat_controller.text.trim().isEmpty ||
                                  long_controller.text.trim().isEmpty ||
                                  partyDistributerId == "TEST") {
                                OurToast()
                                    .showErrorToast("Fields cant be empty");
                              } else {
                                print("Utsav");

                                Map<String, String> toJson = {
                                  "longitude": long_controller.text,
                                  "latitude": lat_controller.text,
                                  "pin_time": time,
                                  "location_type": travellerForId,
                                  "entity_id": travellerForId == "1"
                                      ? partyDistributerId
                                      : partyRetrailerId,
                                };
                                print("helo world");
                                print("helo world");
                                print("helo world");
                                print(toJson);

                                print("helo world");
                                print("helo world");
                                print("helo world");

                                Navigator.pop(context);
                                await APIService().pinlocationAdd(toJson);

                                // }
                              }
                            } else if (travellerForId == "2") {
                              if (lat_controller.text.trim().isEmpty ||
                                  long_controller.text.trim().isEmpty ||
                                  partyRetrailerId == "TEST") {
                                OurToast()
                                    .showErrorToast("Fields cant be empty");
                              } else {
                                print("Utsav");
                                Map<String, String> toJson = {
                                  "longitude": long_controller.text,
                                  "latitude": lat_controller.text,
                                  "pin_time": time,
                                  "location_type": travellerForId,
                                  "entity_id": travellerForId == "1"
                                      ? partyDistributerId
                                      : partyRetrailerId,
                                };
                                print("helo world");
                                print("helo world");
                                print("helo world");
                                print(toJson);
                                print("helo world");
                                print("helo world");
                                print("helo world");
                                Get.find<LoginController>().toggle(true);

                                Navigator.pop(context);
                                await APIService().pinlocationAdd(toJson);
                                // await APIService().tadaPost(jsonData);
                                Get.find<LoginController>().toggle(false);
                              }
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }

  void fetchData() async {
    await APIService().listofdistributer();
    await APIService().listofretrailer();
  }

  record10min() {
    print("Record after 10 min");
    
    timer = Timer.periodic(Duration(seconds: 18000), (Timer t) async {
      int abc = Hive.box<int>("attendance").get("state")!;
      if (abc == 0) {
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
      // print("This function calls every 3 sec");
    });
  }

  // chechNet() async {
  //    CheckConnectivity().initialize();
  // }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        child: OurDrawer(),
      ),
      appBar: AppBar(
        backgroundColor: darklogoColor,
        title: Text(
          "Agricare",
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome ",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(17.5),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable:
                          Hive.box<loginResponseModel>("userprofileDB")
                              .listenable(),
                      builder: (context, Box<loginResponseModel> boxs, child) {
                        loginResponseModel loginResponse =
                            boxs.get("currentUser")!;

                        return Text(
                          loginResponse.userName,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(17.5),
                            color: darklogoColor,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              OurSizedBox(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OurDashBoardScreenTile(
                    title: "Attendance",
                    imageUrl: "assets/images/attendance.png",
                    function: () {
                      // APIService().myattendance();
                      print("My Attendance");
                      Navigator.push(
                        context,
                        PageTransition(
                          child: MyAttendanceScreen(),
                          type: PageTransitionType.leftToRight,
                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
              OurSizedBox(),
              Divider(
                color: logoColor,
              ),
              OurSizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: OurDashBoardScreenTile(
                      title: "TADA",
                      imageUrl: "assets/images/attendance.png",
                      function: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: TADAScreen(),
                            type: PageTransitionType.leftToRight,
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: OurDashBoardScreenTile(
                      title: "Sales Plans",
                      imageUrl: "assets/images/sales_plan.png",
                      function: () {},
                    ),
                  ),
                  Expanded(
                    child: OurDashBoardScreenTile(
                      title: "Visit Plan",
                      imageUrl: "assets/images/visit_plan.png",
                      function: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: VisitPlanScreen(),
                            type: PageTransitionType.leftToRight,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              OurSizedBox(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: OurDashBoardScreenTile(
                      title: "Order Load\n(Distributor)",
                      imageUrl: "assets/images/orderload_distributor.png",
                      function: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              child: OurDistributerOrderLoad(),
                              type: PageTransitionType.leftToRight),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: OurDashBoardScreenTile(
                      title: "Order Load\n(Retailer)",
                      imageUrl: "assets/images/orderload_distributor1.png",
                      function: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              child: RetailerOrderLoad(),
                              type: PageTransitionType.leftToRight),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: OurDashBoardScreenTile(
                      title: "Distributor Stock",
                      imageUrl: "assets/images/distributor_stock.png",
                      function: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              child: DistributorStokeScreen(),
                              type: PageTransitionType.leftToRight),
                        );
                      },
                    ),
                  ),
                ],
              ),
              OurSizedBox(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: OurDashBoardScreenTile(
                      title: "Distributor\nReations",
                      imageUrl: "assets/images/dist_relation.png",
                      function: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              child: DistributerRelationScreen(),
                              type: PageTransitionType.leftToRight),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: OurDashBoardScreenTile(
                      title: "Retailer\nRelations",
                      imageUrl: "assets/images/dist_relation1.png",
                      function: () {},
                    ),
                  ),
                  Expanded(
                    child: OurDashBoardScreenTile(
                      title: "Products",
                      imageUrl: "assets/images/products.png",
                      function: () async {},
                    ),
                  ),
                ],
              ),
              OurSizedBox(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: OurDashBoardScreenTile(
                      title: "Demos",
                      imageUrl: "assets/images/demos.png",
                      function: () {},
                    ),
                  ),
                  Expanded(
                    child: OurDashBoardScreenTile(
                      title: "Farmers Field Day",
                      imageUrl: "assets/images/farmer.png",
                      function: () {},
                    ),
                  ),
                  Expanded(
                    child: OurDashBoardScreenTile(
                      title: "Farmers",
                      imageUrl: "assets/images/farmer.png",
                      function: () {},
                    ),
                  ),
                ],
              ),
              OurSizedBox(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: OurDashBoardScreenTile(
                      title: "Pin location",
                      imageUrl: "assets/images/location_pin.png",
                      function: () {
                        setState(() {
                          dateoftravel = DateTime.now();
                          date_controller.clear();
                          value = null;
                          travellerForId = "1";
                          showdistributer = true;
                          partyDistributerName = null;
                          partyDistributerId = "TEST";
                          partyRetrailerName = null;
                          partyRetrailerId = "TEST";
                          lat_controller.clear();
                          long_controller.clear();
                        });
                        Get.find<pinlocationController>().clearData();
                        // Get.find<pinlocationController>().longitude.value = 0.0;
                        openBottomSheet(context);
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
