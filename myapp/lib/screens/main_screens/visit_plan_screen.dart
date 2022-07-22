import 'package:flutter/material.dart';
import 'package:flutter_dropdown_search/flutter_dropdown_search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myapp/controller/visitpan_controller.dart';
import 'package:myapp/models/visit_plan_model.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import 'package:myapp/widgets/our_visit_plan_card.dart';
import '../../api_services/api_service.dart';
import '../../controller/distributer_controller.dart';
import '../../controller/login_controller.dart';
import '../../controller/retrailer_controller.dart';
import '../../controller/search_text_controller.dart';
import '../../utils/color.dart';
import '../../widgets/our_flutter_toast.dart';
import '../../widgets/our_sized_box.dart';
import '../../widgets/our_spinner.dart';

class VisitPlanScreen extends StatefulWidget {
  const VisitPlanScreen({Key? key}) : super(key: key);

  @override
  State<VisitPlanScreen> createState() => _VisitPlanScreenState();
}

class _VisitPlanScreenState extends State<VisitPlanScreen> {
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

  TextEditingController date_controller = TextEditingController();
  TextEditingController from_controller = TextEditingController();
  TextEditingController to_controller = TextEditingController();
  String? retrailerName;
  List<String> retrailerID = [];

  String? partyDistributerName;
  String partyDistributerId = "TEST";
  String? partyRetrailerName;
  String partyRetrailerId = "TEST";
  TextEditingController _distributer_name_controller = TextEditingController();
  TextEditingController _retailer_name_controller = TextEditingController();
  TextEditingController _retailer_add_name_controller = TextEditingController();

  final item = [
    "Distributer",
    "Retailers",
  ];
  String travellerForId = "1";
  bool showdistributer = true;

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
  DateTime dateoftravel = DateTime.now();

  void openBottomSheel(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return Container(
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
                                  "Add New Visit Plan",
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
                                    lastDate: DateTime(2092),
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
                                    dateoftravel = dateTime;
                                    date_controller.text =
                                        "${dateTime.year}/${dateTime.month}/${dateTime.day}";
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
                          "Type:",
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
                          "Visit to:",
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
                                    "From:",
                                    style: TextStyle(
                                      color: darklogoColor,
                                      fontSize: ScreenUtil().setSp(17.5),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  OurSizedBox(),
                                  TextField(
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(17),
                                      color: logoColor,
                                    ),
                                    controller: from_controller,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: "From",
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
                                    "To:",
                                    style: TextStyle(
                                      color: darklogoColor,
                                      fontSize: ScreenUtil().setSp(17.5),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  OurSizedBox(),
                                  TextField(
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(17),
                                      color: logoColor,
                                    ),
                                    controller: to_controller,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: "To",
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
                                      .indexOf(_retailer_add_name_controller
                                          .text
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
                                  OurToast()
                                      .showErrorToast("Select Item to add");
                                }
                              },
                            ),
                          ],
                        ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       border: Border.all(
                        //         color: Colors.grey[500]!,
                        //       ),
                        //       borderRadius: BorderRadius.circular(
                        //         ScreenUtil().setSp(15),
                        //       )),
                        //   padding: EdgeInsets.symmetric(
                        //     horizontal: ScreenUtil().setSp(5),
                        //     vertical: ScreenUtil().setSp(5),
                        //   ),
                        //   child: DropdownButtonHideUnderline(
                        //     child: DropdownButton<String>(
                        //       isDense: true,
                        //       borderRadius: BorderRadius.circular(
                        //         15,
                        //       ),
                        //       isExpanded: true,
                        //       hint: Center(
                        //         child: Text(
                        //           "Retailers",
                        //           style: TextStyle(
                        //             color: logoColor,
                        //             fontSize: ScreenUtil().setSp(
                        //               17.5,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       value: retrailerName,
                        //       onChanged: (value) => setState(() {
                        //         int index = Get.find<RetrailerController>()
                        //             .retrailernameList
                        //             .indexOf(value);
                        //         print(index);
                        //         String id = Get.find<RetrailerController>()
                        //             .retrailerIDList[index];
                        //         retrailerID.contains(id)
                        //             ? OurToast().showErrorToast(
                        //                 "Already added",
                        //               )
                        //             : retrailerID.add(id);
                        //         // partyRetrailerId = id;
                        //         print("Utsav");
                        //         print(id);
                        //         print("Utkrista");

                        //         this.retrailerName = value;
                        //       }),
                        //       items: Get.find<RetrailerController>()
                        //           .retrailernameList
                        //           .map(buildMenuItem)
                        //           .toList(),
                        //     ),
                        //   ),
                        // ),
                        OurSizedBox(),
                        Column(
                          children: retrailerID.map((e) {
                            int index = Get.find<RetrailerController>()
                                .retrailerIDList
                                .indexOf(e);
                            String retailerName =
                                Get.find<RetrailerController>()
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
                              var ids = "";
                              retrailerID.forEach((element) {
                                ids = ids + element + "|";
                              });
                              print(ids);

                              if (travellerForId == "1") {
                                int index = Get.find<DistributerController>()
                                    .distnameList
                                    .indexOf(
                                      _distributer_name_controller.text.trim(),
                                    );
                                print(index);
                                String id = Get.find<DistributerController>()
                                    .distIDList[index];
                                partyDistributerId = id;
                                Map<String, String> toJson = {
                                  "visitDate":
                                      "${dateoftravel.year}/${dateoftravel.month}/${dateoftravel.day}",
                                  "from": from_controller.text.trim(),
                                  "to": to_controller.text.trim(),
                                  "type": travellerForId,
                                  "visitTo": id,
                                  "retailer": ids,
                                };
                                print(toJson);
                                Get.find<LoginController>().toggle(true);
                                Navigator.pop(context);
                                await APIService().addVisitPlan(toJson);
                                Get.find<LoginController>().toggle(false);
                              } else if (travellerForId == "2") {
                                int index = Get.find<RetrailerController>()
                                    .retrailernameList
                                    .indexOf(
                                      _retailer_name_controller.text.trim(),
                                    );
                                print(index);
                                String id = Get.find<RetrailerController>()
                                    .retrailerIDList[index];
                                partyRetrailerId = id;
                                Map<String, String> toJson = {
                                  "visitDate":
                                      "${dateoftravel.year}/${dateoftravel.month}/${dateoftravel.day}",
                                  "from": from_controller.text.trim(),
                                  "to": to_controller.text.trim(),
                                  "type": travellerForId,
                                  "visitTo": partyRetrailerId,
                                  "retailer": ids,
                                };
                                print(toJson);
                                Get.find<LoginController>().toggle(true);
                                Navigator.pop(context);
                                await APIService().addVisitPlan(toJson);
                                Get.find<LoginController>().toggle(false);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgressHUD(
        inAsyncCall: Get.find<LoginController>().processing.value,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: darklogoColor,
            title: Text(
              "Visit Plan",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(25),
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
                          hintText: "Search Visit Plan",
                          hintStyle: TextStyle(
                            color: logoColor,
                            fontSize: ScreenUtil().setSp(17.5),
                          ),
                          fillColor: Colors.white,
                          filled: true,
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
                    stream: VisitPlaController.getVisitPlan(),
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
                                      VisitPlanDataa data =
                                          snapshot.data[index];
                                      return AnimationConfiguration
                                          .staggeredList(
                                        position: index,
                                        duration:
                                            const Duration(milliseconds: 750),
                                        child: SlideAnimation(
                                          horizontalOffset:
                                              ScreenUtil().setSp(50.0),
                                          child: FadeInAnimation(
                                            child: OurVisitPlanCard(
                                              data: data,
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
                                      VisitPlanDataa data =
                                          snapshot.data[index];
                                      // return Text(searchText);
                                      return data.party!.toLowerCase().contains(
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
                                                  child: OurVisitPlanCard(
                                                    data: data,
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
            onPressed: () {
              setState(() {
                showdistributer == true;
                _distributer_name_controller.text = "";
                _retailer_name_controller.text = "";
                _retailer_add_name_controller.text = "";
                from_controller.clear();
                to_controller.clear();
                dateoftravel = DateTime.now();
                date_controller.clear();
                retrailerID = [];
                travellerForId = "1";
                partyDistributerId = "TEST";
                partyRetrailerId = "TEST";
                retrailerName = null;
                partyDistributerName = null;
                partyRetrailerName = null;
                value = null;
              });
              openBottomSheel(context);
              // APIService().addVisitPlan();
            },
            child: Icon(
              Icons.add,
              size: ScreenUtil().setSp(35),
            ),
            backgroundColor: darklogoColor,
          ),
        ),
      ),
    );
  }
}
