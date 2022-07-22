import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/controller/distributer_controller.dart';
import 'package:myapp/models/custom_stoke.dart';
import 'package:myapp/models/distributer_order_load_model.dart';
import 'package:myapp/models/distributer_response_model.dart';
import 'package:myapp/models/login_response_model.dart';
import 'package:myapp/controller/retrailer_controller.dart';
import 'package:myapp/models/product_model.dart';
import 'package:myapp/models/retrailer_response_model.dart';
import 'package:myapp/models/tada_model_response.dart';
import 'package:myapp/models/visit_plan_model.dart';
import 'package:myapp/utils/utils.dart';
import 'package:myapp/widgets/our_flutter_toast.dart';
import 'package:intl/intl.dart';
import '../controller/login_controller.dart';
import '../controller/product_controller.dart';
import '../db/db_helper.dart';
import '../models/attendance_model.dart';
import '../models/distributer_stoke_list_model.dart';
import '../models/retailer_order_load_model.dart';
import '../services/current_location/get_current_location.dart';

class APIService {
  login(Map<String, dynamic> toJson, BuildContext context) async {
    Get.find<LoginController>().toggle(true);
    print("Inside login API");
    String url = "https://api.agricare.com.np/site/mobauth";
    try {
      final response = await http.post(Uri.parse(url), body: (toJson));
      // print(response.body);
      if (response.statusCode == 200) {
        print(response.body.runtimeType);
        print("status code 200");
        String responseJson = json.decode(response.body);
        Map<String, dynamic> responseJson2 = json.decode(responseJson);

        loginResponseModel loginResponse =
            loginResponseModel.fromJson(responseJson2);
        Hive.box<String>(DatabaseHelper.authenticationDB).put(
          "state",
          loginResponse.token,
        );
        Hive.box<loginResponseModel>("userprofileDB").put(
          "currentUser",
          loginResponse,
        );
        print(loginResponse);
      } else {
        print(response.body);
        print("Error");
        print("Status code ${response.statusCode}");
      }
      Get.find<LoginController>().toggle(false);
    } catch (e) {
      print(e);
      print("ERROR");
      OurToast().showErrorToast("Error occured");
      Get.find<LoginController>().toggle(false);
    }
  }

  myattendance(AttendanceModel attendanceType) async {
    print("Utsav123 123");

    Get.find<LoginController>().toggle(true);
    print("Inside my attendance");
    Position? position;
    String attendance = Hive.box<int>("attendance").get("state").toString();
    String token =
        Hive.box<loginResponseModel>("userprofileDB").get("currentUser")!.token;
    int mr = Hive.box<loginResponseModel>("userprofileDB")
        .get("currentUser")!
        .userId;
    String url =
        "https://api.agricare.com.np/index.php/mrpost/timepost?token=$token";
    position = await GetCurrentLocation().getCurrentLocation();
    String currentTime = Utils().toDateTime(DateTime.now());
    print(position);
    print(url);
    print(mr);
    print(currentTime);
    try {
      final response = await http.post(Uri.parse(url),
          body: ({
            "mr": attendanceType.mr,
            "longitude": attendanceType.longitude,
            "latitude": attendanceType.latitude,
            "signal": attendanceType.signal,
            "stamp_time": attendanceType.stamp_time
          }));
      if (response.statusCode == 200) {
        print("Inside Status code 200");
        print(response.body);
        Get.find<LoginController>().toggle(false);
      } else {
        print("Inside status code ${response.statusCode}");
        print(response.body);
        Get.find<LoginController>().toggle(false);
      }
    } catch (e) {
      print(e);
      Get.find<LoginController>().toggle(false);
    }
  }

  mybackgroundattendance(AttendanceModel attendanceType) async {
    Get.find<LoginController>().toggle(true);
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm:s');
    String inputDate = inputFormat
        .parse(
          DateTime.now().toString(),
        )
        .toString();
    String time = inputDate.split(".000")[0];
    print("Inside my background attendance");
    Position? position;
    String attendance = Hive.box<int>("attendance").get("state").toString();
    String token =
        Hive.box<loginResponseModel>("userprofileDB").get("currentUser")!.token;
    int mr = Hive.box<loginResponseModel>("userprofileDB")
        .get("currentUser")!
        .userId;
    String url =
        "https://api.agricare.com.np/index.php/mrpost/timepost?token=$token";
    position = await GetCurrentLocation().getCurrentLocation();
    String currentTime = Utils().toDateTime(DateTime.now());
    print(position);
    print(url);
    print(mr);
    print(currentTime);
    try {
      final response = await http.post(Uri.parse(url),
          body: ({
            "mr": attendanceType.mr,
            "longitude": attendanceType.longitude,
            "latitude": attendanceType.latitude,
            "signal": attendanceType.signal,
            "stamp_time": attendanceType.stamp_time
          }));
      if (response.statusCode == 200) {
        print("Inside Status code 200");
        print(response.body);
        Get.find<LoginController>().toggle(false);
      } else {
        print("Inside status code ${response.statusCode}");
        print(response.body);
        Get.find<LoginController>().toggle(false);
      }
    } catch (e) {
      print(e);
      Get.find<LoginController>().toggle(false);
    }
  }

  static Future<List<dataa>?> mytadalist() async {
    // print("Inside tada api");
    List<dataa> _responses = [];
    String token =
        Hive.box<loginResponseModel>("userprofileDB").get("currentUser")!.token;
    String url = "https://api.agricare.com.np/index.php/mr/tada?token=$token";
    print(url);
    try {
      final response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseJson = json.decode(response.body);
        responseJson.forEach((key, value) {
          _responses.add(dataa.fromJson(value));
        });
        return _responses;
      } else {
        print("Inside status code ${response.statusCode}");
        print(response.body);
        // return _responses;
      }
    } catch (e) {
      // return _responses;

      print("Error aaiyo");
      print(e);
    }
  }

  listofdistributer() async {
    print("Inside list of distributer api");
    List<DistributerResponseModel> _responses = [];
    List<String> _distname_responses = [];
    List<String> _distId_responses = [];
    String token =
        Hive.box<loginResponseModel>("userprofileDB").get("currentUser")!.token;
    String url =
        "http://api.agricare.com.np/index.php/mr/distributors?token=$token";
    try {
      final response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        print("Inside Status code 200");
        print(response.body);
        var responseJson = json.decode(response.body);
        responseJson.forEach((e) {
          // print(e);
          _distname_responses.add(e["dist_name"]);
          _distId_responses.add(e["id"]);
          print(e["id"]);
          print(e["dist_name"]);
          _responses.add(DistributerResponseModel.fromJson(e));
        });
        Get.find<DistributerController>().adddistnamelist(_distname_responses);
        Get.find<DistributerController>().adddistIDlist(_distId_responses);
        // print(_responses);
      } else {
        print("Inside status code ${response.statusCode}");
        print(response.body);
      }
    } catch (e) {
      print("Error aaiyo");
      print(e);
    }
  }

  listofretrailer() async {
    print("Inside list of retrailer api");
    List<String> _retrailername_responses = [];
    List<String> _retrailerId_responses = [];
    List<RetrailerResponseModel> _responses = [];
    String token =
        Hive.box<loginResponseModel>("userprofileDB").get("currentUser")!.token;
    String url =
        "https://api.agricare.com.np/index.php/mr/retailers?token=$token";
    try {
      final response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        responseJson.forEach((e) {
          print(e);
          _retrailerId_responses.add(e["id"]);
          _retrailername_responses.add(e["retail_name"]);

          _responses.add(RetrailerResponseModel.fromJson(e));
        });
        // print(_responses);
        Get.find<RetrailerController>()
            .addretrailernamelist(_retrailername_responses);
        Get.find<RetrailerController>()
            .addretrailerIDlist(_retrailerId_responses);
      } else {
        print("Inside status code ${response.statusCode}");
      }
    } catch (e) {
      print("Error aaiyo");
      print(e);
    }
  }

  tadaPost(Map<String, String> tojson) async {
    String token =
        Hive.box<loginResponseModel>("userprofileDB").get("currentUser")!.token;
    String url =
        "https://api.agricare.com.np/index.php/mrpost/tada?token=$token";
    print(url);
    print(tojson);
    try {
      final response = await http.post(
        Uri.parse(url),
        body: (tojson),
      );
      if (response.statusCode == 200) {
        print("Inside Status code 200");
        print(response.body);
        OurToast().showSuccessToast("Tada added");
        Get.find<LoginController>().toggle(false);
      } else {
        OurToast().showErrorToast("Error occured");

        print("Inside status code ${response.statusCode}");
        print(response.body);
        Get.find<LoginController>().toggle(false);
      }
    } catch (e) {
      print(e);
      OurToast().showErrorToast("Error occured");
    }
  }

  static Future<List<VisitPlanDataa>?> myVisitPlan() async {
    List<VisitPlanDataa> _responses = [];
    String token =
        Hive.box<loginResponseModel>("userprofileDB").get("currentUser")!.token;
    String url =
        "https://api.agricare.com.np/index.php/mr/visitplan?token=$token";
    // print(url);
    try {
      final response = await http.get(
        Uri.parse(url),
      );
      // print(response.body);
      if (response.statusCode == 200) {
        // print("Inside status code 200");
        Map<String, dynamic> responseJson = json.decode(response.body);
        responseJson.isNotEmpty
            ? responseJson.forEach((key, value) {
                VisitPlanDataa visitPlanDataa = VisitPlanDataa.fromJson(value);
                _responses.add(
                  VisitPlanDataa.fromJson(value),
                );
              })
            : null;
        return _responses;
      } else {
        // print(response.statusCode);
      }
    } catch (e) {
      print(e);
      print("Error occured");
    }
  }

  static Future<List<DistributerorderloadData>?>
      distributer_order_load() async {
    List<DistributerorderloadData> _responses = [];

    String token =
        Hive.box<loginResponseModel>("userprofileDB").get("currentUser")!.token;
    String url =
        "https://api.agricare.com.np/index.php/mr/distorders?token=$token";
    // print(url);
    try {
      final response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        print("Inside Status code 200");
        Map<String, dynamic> responseJson = json.decode(response.body);
        responseJson.forEach((key, value) {
          DistributerorderloadData distributerorderloadData =
              DistributerorderloadData.fromJson(value);
          // print(value);
          _responses.add(DistributerorderloadData.fromJson(value));
        });
        // print(_responses);
        return _responses;

        // print(responseJson);
        // print(response.body);
      } else {
        print("Inside status code ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      print("Error occured");
    }
  }

  addVisitPlan(Map<String, String> tojson) async {
    print("Inside addss visit plan");
    String token =
        Hive.box<loginResponseModel>("userprofileDB").get("currentUser")!.token;
    String url =
        "https://api.agricare.com.np/index.php/mrpost/visitplan?token=$token";
    print(url);
    try {
      final response = await http.post(Uri.parse(url), body: tojson);
      print("==========");
      print(response.body);
      print("++++++++");
      if (response.statusCode == 200) {
        print("Inside Status code 200");
        print(response);
        print(response.body);
        print("utsav");
        print("utkrista");
      } else {
        print("Inside status code ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      print("Error occured");
    }
  }

  pinlocationAdd(Map<String, String> toJson) async {
    String token =
        Hive.box<loginResponseModel>("userprofileDB").get("currentUser")!.token;
    String url =
        "https://api.agricare.com.np/index.php/mrpost/pinlocation?token=$token";
    print(url);
    try {
      final response = await http.post(Uri.parse(url), body: toJson);
      print("==========");
      print(response.body);
      print("++++++++");
      if (response.statusCode == 200) {
        print("Inside Status code 200");
        print(response);
        print(response.body);
        print("utsav");
        print("utkrista");
        OurToast().showErrorToast("Your entry has been recorded");
      } else {
        print("Inside status code ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      print("Error occured");
    }
  }

  Future<List<Productdataa>?> listofProduct() async {
    print("Inside list of product");
    String token =
        Hive.box<loginResponseModel>("userprofileDB").get("currentUser")!.token;
    String url =
        "https://api.agricare.com.np/index.php/mr/products?token=$token";
    print(url);
    List<String> _productname_responses = [];
    List<String> _product_Id_responses = [];
    List<Productdataa> _responses = [];
    try {
      final response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        print("Inside status code 200");
        print(response.body);
        Map<String, dynamic> responseJson = json.decode(response.body);
        responseJson.forEach((key, value) {
          Productdataa productDataResponseModel = Productdataa.fromJson(value);
          _product_Id_responses.add(productDataResponseModel.itemId.toString());
          _productname_responses
              .add(productDataResponseModel.itemName.toString());

          _responses.add(productDataResponseModel);
          // print(productDataResponseModel);
        });
        Get.find<ProductController>().addproductIDlist(_product_Id_responses);
        Get.find<ProductController>()
            .addproductnamelist(_productname_responses);
        return _responses;
      } else {
        print("Inside status code ${response.statusCode}");
        return _responses;
      }
    } catch (e) {
      print("Error occured");
      print(e);
    }
  }

  adddistributerOrder(Map<String, dynamic> toJson, String id) async {
    print("Inside add distributer orders");
    String token =
        Hive.box<loginResponseModel>("userprofileDB").get("currentUser")!.token;
    String url =
        "https://api.agricare.com.np/mrpost/distorder?token=$token&distributor=$id";
    print(url);
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: (jsonEncode(toJson)),
      );
      print("==========");
      print(response.body);
      print("++++++++");
      if (response.statusCode == 200) {
        print("Inside Status code 200");
        print(response);
        print(response.body);
        print("utsav");
        print("utkrista");
        OurToast().showErrorToast("Added");
      } else {
        print("Inside status code ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      print("Error occured");
    }
  }

  static Future<List<Retailerlistdata>?> retailerorderlist() async {
    print("Inside retailer orders list");
    List<Retailerlistdata> _responses = [];
    String token =
        Hive.box<loginResponseModel>("userprofileDB").get("currentUser")!.token;
    String url =
        "https://api.agricare.com.np/index.php//mr/retorders?token=$token";
    // print(url);
    try {
      final response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        // print("inside status code 200");
        Map<String, dynamic> responseJson = json.decode(response.body);
        // print(response.body);
        responseJson.forEach((key, value) {
          Retailerlistdata retailerlistdata = Retailerlistdata.fromJson(value);
          print(responseJson);
          // print(value);
          _responses.add(Retailerlistdata.fromJson(value));
        });
        // print(_responses);
        return _responses;
      } else {
        print("Inside Status code ${response.statusCode}");
      }
    } catch (e) {
      print("e");
      print("Error occured");
    }
  }

  addRetailerOrder(
      Map<String, dynamic> toJson, String id, BuildContext context) async {
    print("Inside add retailer orders");
    String token =
        Hive.box<loginResponseModel>("userprofileDB").get("currentUser")!.token;
    String url =
        "https://api.agricare.com.np/index.php/mrpost/retorder?token=$token&distributor=$id";
    print(url);
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: (jsonEncode(toJson)),
      );
      print("==========");
      print(response.body);
      print("++++++++");
      if (response.statusCode == 200) {
        print("Inside Status code 200");
        print(response);
        print(response.body);
        print("utsav");
        print("utkrista");
        OurToast().showErrorToast("Added");
        Navigator.pop(context);
      } else {
        OurToast().showErrorToast("Error occured");
        print("Inside status code ${response.statusCode}");
      }
    } catch (e) {
      OurToast().showErrorToast("Error occured");

      print(e);
      print("Error occured");
    }
  }

  static Future<List<CustomStokeData>?> getDistributerStokeList() async {
    print("INSIDE GET DISTRIBUTER STOKE LIST");
    List<CustomStokeData> _responses = [];
    String token =
        Hive.box<loginResponseModel>("userprofileDB").get("currentUser")!.token;
    String url =
        "https://api.agricare.com.np/index.php/mr/diststock?token=$token";
    // print(url);
    try {
      final response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseJson = json.decode(response.body);
        // print(responseJson);
        responseJson.forEach((key, value) {
          List<CustomStokeDownData> metalist = [];
          value["meta"].values.forEach((e) {
            // print(e);
            CustomStokeDownData customStokeDownData =
                CustomStokeDownData.fromMap(e);
            metalist.add(customStokeDownData);
            // print(customStokeDownData.toJson());
          });
          // print(value["stock_id"]);
          // print(value["distributor"]);
          // print(value["statedate"]);
          // print(metalist);
          CustomStokeData customStokeData = CustomStokeData(
            stokeId: value["stock_id"],
            distributor: value["distributor"],
            statedate: value["statedate"],
            meta: metalist,
          );
          // print(customStokeData.toJson());
          _responses.add(customStokeData);

          // print("----------");
        });
        // print(_responses);
        return _responses;
      } else {
        print("Inside status code ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      print("Error occured");
    }
  }

  addDistributerStock(
      Map<String, dynamic> toJson, String id, BuildContext context) async {
    print("Inside add distributer stock.");
    String token =
        Hive.box<loginResponseModel>("userprofileDB").get("currentUser")!.token;
    String url =
        "https://api.agricare.com.np/mrpost/diststock?token=$token&distributor=$id";
    print(url);
    print(toJson);
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: (jsonEncode(toJson)),
      );
      print("==========");
      print(response.body);
      print("++++++++");
      if (response.statusCode == 200) {
        print("Inside Status code 200");
        print(response);
        print(response.body);
        print("utsav");
        print("utkrista");
        OurToast().showErrorToast("Added");
        Navigator.pop(context);
      } else {
        OurToast().showErrorToast("Error occured");
        print("Inside status code ${response.statusCode}");
      }
    } catch (e) {
      OurToast().showErrorToast("Error occured");

      print(e);
      print("Error occured");
    }
  }
}
