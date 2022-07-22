import 'package:flutter/material.dart';
import 'package:flutter_dropdown_search/flutter_dropdown_search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myapp/api_services/api_service.dart';
import 'package:myapp/controller/distributer_controller.dart';
import 'package:myapp/controller/retrailer_controller.dart';
import 'package:myapp/models/tada_model_response.dart';
import 'package:myapp/utils/color.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import 'package:myapp/widgets/our_flutter_toast.dart';
import 'package:myapp/widgets/our_sized_box.dart';
import 'package:myapp/widgets/our_spinner.dart';
import 'package:myapp/widgets/our_tada_card.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:intl/intl.dart';

import '../../controller/login_controller.dart';
import '../../controller/search_text_controller.dart';
import '../../controller/tada_controller.dart';

class TADAScreen extends StatefulWidget {
  const TADAScreen({Key? key}) : super(key: key);

  @override
  State<TADAScreen> createState() => _TADAScreenState();
}

class _TADAScreenState extends State<TADAScreen> {
  TextEditingController date_controller = TextEditingController();
  TextEditingController _distributer_name_controller = TextEditingController();
  TextEditingController _retailer_name_controller = TextEditingController();
  TextEditingController _retailer_add_name_controller = TextEditingController();
  var nepalidateformatter = NepaliDateFormat.yMd();
  String? retrailerName;
  String travellerForId = "1";
  List<String> retrailerID = [];
  String? partyDistributerName;
  String partyDistributerId = "TEST";
  String? partyRetrailerName;
  String partyRetrailerId = "TEST";
  bool showdistributer = true;
  // void fetchData(){
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    setState(() {
      date_controller.text =
          "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}";
    });
    Get.find<SearchTextController>().clearController();
  }

  void fetchData() async {
    await APIService().listofdistributer();
    await APIService().listofretrailer();
  }

  final item = [
    "Distributer",
    "Retailers",
  ];
  String? value;
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
  String searchText = "";
  DateTime dateoftravel = DateTime.now();
  TextEditingController start_location_controller = TextEditingController();
  TextEditingController end_location_controller = TextEditingController();
  TextEditingController km_covered_controller = TextEditingController();
  TextEditingController Ta_controller = TextEditingController();
  void openBottomSheel(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
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
                                "Add New TADA",
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
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now(),
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
                            // child: Text(
                            //   "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}",
                            //   style: TextStyle(
                            //     fontSize: ScreenUtil().setSp(17),
                            //     fontWeight: FontWeight.w400,
                            //   ),
                            // ),
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
                          ? FlutterDropdownSearch(
                              hintText: "Party",
                              hintStyle: TextStyle(
                                fontSize: ScreenUtil().setSp(17.5),
                                fontWeight: FontWeight.w400,
                                // color: logoColor,
                              ),
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(17.5),
                                fontWeight: FontWeight.w400,
                                // color: logoColor,
                              ),
                              textController: _distributer_name_controller,
                              items: Get.find<DistributerController>()
                                  .distnameList,
                              dropdownHeight: 300,
                            )
                          : FlutterDropdownSearch(
                              hintText: "Party",
                              hintStyle: TextStyle(
                                fontSize: ScreenUtil().setSp(17.5),
                                fontWeight: FontWeight.w400,
                                // color: logoColor,
                              ),
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(17.5),
                                fontWeight: FontWeight.w400,
                                // color: logoColor,
                              ),
                              textController: _retailer_name_controller,
                              items: Get.find<RetrailerController>()
                                  .retrailernameList,
                              dropdownHeight: 300,
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
                                  "Start Location:",
                                  style: TextStyle(
                                    color: darklogoColor,
                                    fontSize: ScreenUtil().setSp(17.5),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setSp(4),
                                ),
                                TextField(
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(17),
                                    color: logoColor,
                                  ),
                                  controller: start_location_controller,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "Location",
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
                                  "End Location:",
                                  style: TextStyle(
                                    color: darklogoColor,
                                    fontSize: ScreenUtil().setSp(17.5),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setSp(4),
                                ),
                                TextField(
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(17),
                                    color: logoColor,
                                  ),
                                  controller: end_location_controller,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "Location",
                                  ),
                                ),
                              ],
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
                              children: [
                                Text(
                                  "KM Covered:",
                                  style: TextStyle(
                                    color: darklogoColor,
                                    fontSize: ScreenUtil().setSp(17.5),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setSp(4),
                                ),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(17),
                                    color: logoColor,
                                  ),
                                  controller: km_covered_controller,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "Distance",
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
                              children: [
                                Text(
                                  "DA Amount(Rs):",
                                  style: TextStyle(
                                    color: darklogoColor,
                                    fontSize: ScreenUtil().setSp(17.5),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setSp(4),
                                ),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(17),
                                    color: logoColor,
                                  ),
                                  controller: Ta_controller,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "Amount",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      OurSizedBox(),
                      Text(
                        "Retailers:",
                        style: TextStyle(
                          color: darklogoColor,
                          fontSize: ScreenUtil().setSp(17.5),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      OurSizedBox(),
                      Row(
                        children: [
                          Expanded(
                            child: FlutterDropdownSearch(
                              hintText: "Retailer",
                              hintStyle: TextStyle(
                                fontSize: ScreenUtil().setSp(17.5),
                                fontWeight: FontWeight.w400,
                                // color: logoColor,
                              ),
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(17.5),
                                fontWeight: FontWeight.w400,
                                // color: logoColor,
                              ),
                              textController: _retailer_add_name_controller,
                              items: Get.find<RetrailerController>()
                                  .retrailernameList,
                              dropdownHeight: 300,
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().setSp(15),
                          ),
                          OurElevatedButton(
                            title: "Add",
                            function: () {
                              if (_retailer_add_name_controller.text.trim() !=
                                  null) {
                                int index = Get.find<RetrailerController>()
                                    .retrailernameList
                                    .indexOf(_retailer_add_name_controller.text
                                        );
                                print(index);
                                String id = Get.find<RetrailerController>()
                                    .retrailerIDList[index];
                                if (retrailerID.contains(id)) {
                                  OurToast()
                                      .showErrorToast("Item Already Added");
                                } else {
                                  // retrailerID.add(id);
                                  // AddProductModel addProductModel =
                                  //     AddProductModel(
                                  //         batch: "",
                                  //         productName:
                                  //             _product_name_controller.text
                                  //                 .trim(),
                                  //         productId: id,
                                  //         qty: 1,
                                  //         freeQty: 1);

                                  // print(addProductModel.toJson());
                                  setState(() {
                                    retrailerID.add(id);
                                  });
                                }
                              } else {
                                OurToast().showErrorToast("Select Item to add");
                              }
                            },
                          ),
                        ],
                      ),
                      OurSizedBox(),
                      Column(
                        children: retrailerID.map((e) {
                          int index = Get.find<RetrailerController>()
                              .retrailerIDList
                              .indexOf(e);
                          String retailerName = Get.find<RetrailerController>()
                              .retrailernameList[index];
                          return Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setSp(3),
                              vertical: ScreenUtil().setSp(3),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setSp(3),
                              vertical: ScreenUtil().setSp(3),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    retailerName,
                                    style: TextStyle(
                                      color: darklogoColor,
                                      fontSize: ScreenUtil().setSp(
                                        17.5,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      retrailerID.remove(e);
                                    });
                                  },
                                  child: Icon(
                                    Icons.cancel,
                                    color: darklogoColor,
                                    size: ScreenUtil().setSp(20),
                                  ),
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      OurSizedBox(),
                      Center(
                        child: OurElevatedButton(
                          title: "Submit",
                          function: () async {
                            if (travellerForId == "1") {
                              if (start_location_controller.text
                                      .trim()
                                      .isEmpty ||
                                  end_location_controller.text.trim().isEmpty ||
                                  km_covered_controller.text.trim().isEmpty ||
                                  Ta_controller.text.trim().isEmpty ||
                                  retrailerID.isEmpty ||
                                  _distributer_name_controller == "") {
                                OurToast()
                                    .showErrorToast("Fields cant be empty");
                              } else {
                                print("Utsav");
                                var ids = "";
                                retrailerID.forEach((element) {
                                  ids = ids + element + "|";
                                });
                                int index = Get.find<DistributerController>()
                                    .distnameList
                                    .indexOf(
                                      _distributer_name_controller.text.trim(),
                                    );
                                print(index);
                                String id = Get.find<DistributerController>()
                                    .distIDList[index];
                                partyDistributerId = id;
                                print(ids);
                                Map<String, String> jsonData = {
                                  "tadadate":
                                      "${dateoftravel.year}/${dateoftravel.month}/${dateoftravel.day}",
                                  "travelling_for": travellerForId,
                                  "forname": partyDistributerId,
                                  "start_location":
                                      start_location_controller.text.trim(),
                                  "stop_location":
                                      end_location_controller.text.trim(),
                                  "kmcovered":
                                      km_covered_controller.text.trim(),
                                  "aux": ids,
                                  "da": Ta_controller.text.trim(),
                                };
                                print("helo world");
                                print("helo world");
                                print("helo world");

                                print(jsonData);
                                print("helo world");
                                print("helo world");
                                print("helo world");

                                Navigator.pop(context);
                                await APIService().tadaPost(jsonData);

                                // }
                              }
                            } else if (travellerForId == "2") {
                              if (start_location_controller.text
                                      .trim()
                                      .isEmpty ||
                                  end_location_controller.text.trim().isEmpty ||
                                  km_covered_controller.text.trim().isEmpty ||
                                  Ta_controller.text.trim().isEmpty ||
                                  retrailerID.isEmpty ||
                                  _retailer_name_controller.text.trim() == "") {
                                OurToast()
                                    .showErrorToast("Fields cant be empty");
                              } else {
                                print("Utsav");
                                var ids = "";
                                retrailerID.forEach((element) {
                                  ids = ids + element + "|";
                                });
                                print(ids);
                                int index = Get.find<RetrailerController>()
                                    .retrailernameList
                                    .indexOf(
                                      _retailer_name_controller.text.trim(),
                                    );
                                print(index);
                                String id = Get.find<RetrailerController>()
                                    .retrailerIDList[index];
                                partyRetrailerId = id;
                                Map<String, String> jsonData = {
                                  "tadadate":
                                      "${dateoftravel.year}/${dateoftravel.month}/${dateoftravel.day}",
                                  "travelling_for": travellerForId,
                                  "forname": partyRetrailerId,
                                  "start_location":
                                      start_location_controller.text.trim(),
                                  "stop_location":
                                      end_location_controller.text.trim(),
                                  "kmcovered":
                                      km_covered_controller.text.trim(),
                                  "aux": ids,
                                  "da": Ta_controller.text.trim(),
                                };
                                print("helo world");
                                print("helo world");
                                print("helo world");
                                print(jsonData);
                                print("helo world");
                                print("helo world");
                                print("helo world");
                                Get.find<LoginController>().toggle(true);

                                Navigator.pop(context);
                                await APIService().tadaPost(jsonData);
                                Get.find<LoginController>().toggle(false);

                                // }
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

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
        inAsyncCall: Get.find<LoginController>().processing.value,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: darklogoColor,
            title: Text(
              "TADA Report",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(25),
                // fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          body: Container(
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setSp(7.5),
              vertical: ScreenUtil().setSp(7.5),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setSp(7.5),
              vertical: ScreenUtil().setSp(7.5),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Obx(
                    () => Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setSp(10),
                        vertical: ScreenUtil().setSp(7.5),
                      ),
                      height: ScreenUtil().setSp(45),
                      child: TextField(
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        onChanged: (value) {
                          print("object");
                          Get.find<SearchTextController>().changeValue(value);
                          setState(() {
                            searchText = Get.find<SearchTextController>()
                                .searchText
                                .value;
                          });
                        },
                        style: TextStyle(
                          color: logoColor,
                          fontSize: ScreenUtil().setSp(17.5),
                        ),
                        controller: Get.find<SearchTextController>()
                            .search_controller
                            .value,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setSp(5),
                            vertical: ScreenUtil().setSp(1),
                          ),
                          isDense: true,
                          focusColor: logoColor,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: logoColor,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                ScreenUtil().setSp(10),
                              ),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: logoColor,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                ScreenUtil().setSp(10),
                              ),
                            ),
                          ),
                          hintText: "Search TADA report",
                          hintStyle: TextStyle(
                            color: logoColor,
                            fontSize: ScreenUtil().setSp(17.5),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          // prefixIcon: Icon(
                          //   Icons.search,
                          //   size: ScreenUtil().setSp(25),
                          //   color: logoColor,
                          // ),
                          suffixIcon: Get.find<SearchTextController>()
                                  .searchText
                                  .trim()
                                  .isEmpty
                              ? Icon(null)
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      searchText = "";
                                    });
                                    Get.find<SearchTextController>()
                                        .clearController();
                                    // setState(() {
                                    //   indexs.clear();
                                    // });
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    size: ScreenUtil().setSp(25),
                                    color: darklogoColor,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: TadaController.getTada(),
                    // initialData: InitialData,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data.length > 0
                            ? searchText.trim().isEmpty
                                ? AnimationLimiter(
                                    child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return AnimationConfiguration
                                          .staggeredList(
                                        position: index,
                                        duration:
                                            const Duration(milliseconds: 750),
                                        child: SlideAnimation(
                                          horizontalOffset:
                                              ScreenUtil().setSp(50.0),
                                          child: FadeInAnimation(
                                            child: OurTadaCard(
                                              tada_mode_response:
                                                  snapshot.data[index],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ))
                                : AnimationLimiter(
                                    child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (BuildContext context, index) {
                                      dataa data = snapshot.data[index];
                                      // return Text(searchText);
                                      return data.meta!.party!
                                              .toLowerCase()
                                              .contains(
                                                  searchText.toLowerCase())
                                          ? AnimationConfiguration
                                              .staggeredList(
                                              position: index,
                                              duration: const Duration(
                                                  milliseconds: 750),
                                              child: SlideAnimation(
                                                horizontalOffset:
                                                    ScreenUtil().setSp(50.0),
                                                child: FadeInAnimation(
                                                  child: OurTadaCard(
                                                    tada_mode_response:
                                                        snapshot.data[index],
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Center();
                                    },
                                  ))
                            : Center(
                                child: Text(
                                  "No Data",
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(20),
                                    color: logoColor,
                                  ),
                                ),
                              );
                      } else {
                        return Center(
                          child: OurSpinner(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: darklogoColor,
            onPressed: () {
              setState(() {
                _distributer_name_controller.text = "";
                _retailer_name_controller.text = "";
                _retailer_add_name_controller.text = "";
                dateoftravel = DateTime.now();
                date_controller.clear();
                start_location_controller.clear();
                end_location_controller.clear();
                km_covered_controller.clear();
                Ta_controller.clear();
                retrailerID = [];
                travellerForId = "1";
                partyDistributerId = "TEST";
                partyRetrailerId = "TEST";
                retrailerName = null;
                partyDistributerName = null;
                partyRetrailerName = null;
                value = null;
                showdistributer = true;
              });

              openBottomSheel(context);
            },
            child: Icon(
              Icons.add,
              size: ScreenUtil().setSp(35),
            ),
          ),
        ),
      ),
    );
  }
}
