import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_dropdown_search/flutter_dropdown_search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:myapp/api_services/api_service.dart';
import 'package:myapp/models/add_product_model.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import 'package:myapp/widgets/our_stock_card.dart';

import '../../controller/distrbuter_stoke_controller.dart';
import '../../controller/distributer_controller.dart';
import '../../controller/product_controller.dart';
import '../../controller/search_text_controller.dart';
import '../../models/custom_stoke.dart';
import '../../models/distributer_stoke_list_model.dart';
import '../../models/product_model.dart';
import '../../utils/color.dart';
import '../../widgets/our_flutter_toast.dart';
import '../../widgets/our_sized_box.dart';
import '../../widgets/our_spinner.dart';

class DistributorStokeScreen extends StatefulWidget {
  const DistributorStokeScreen({Key? key}) : super(key: key);

  @override
  State<DistributorStokeScreen> createState() => _DistributorStokeScreenState();
}

class _DistributorStokeScreenState extends State<DistributorStokeScreen> {
  TextEditingController date_controller = TextEditingController();
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
    await APIService().listofProduct();

    await APIService().listofdistributer();
  }

  TextEditingController _product_name_controller = TextEditingController();
  TextEditingController _distributer_name_controller = TextEditingController();
  DateTime dateoftravel = DateTime.now();
  List<Productdataa>? productData = [];
  String partyDistributerId = "TEST";
  String? distributervalue;
  String? value;
  List<AddProductModel> addProductModelList = [];
  List<String> addedItemId = [];
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
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  "Add Distributer stoke",
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
                              "Entry Date:",
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
                        FlutterDropdownSearch(
                          hintText: "Distributor",
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
                          items: Get.find<DistributerController>().distnameList,
                          dropdownHeight: 300,
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
                        //           "Distributer",
                        //           style: TextStyle(
                        //             color: logoColor,
                        //             fontSize: ScreenUtil().setSp(
                        //               17.5,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       value: distributervalue,
                        //       onChanged: (value) => setState(() {
                        //         this.distributervalue = value;
                        // int index = Get.find<DistributerController>()
                        //     .distnameList
                        //     .indexOf(value);
                        // print(index);
                        // String id = Get.find<DistributerController>()
                        //     .distIDList[index];
                        // partyDistributerId = id;
                        //         print("Utsav");
                        //         print(id);
                        //         print("Utkrista");
                        //       }),
                        //       items: Get.find<DistributerController>()
                        //           .distnameList
                        //           .map(buildMenuItem)
                        //           .toList(),
                        //     ),
                        //   ),
                        // ),
                        OurSizedBox(),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: FlutterDropdownSearch(
                                hintText: "Product",
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
                                textController: _product_name_controller,
                                items: Get.find<ProductController>()
                                    .productNameList,
                                dropdownHeight: 300,
                              ),
                            ),
                            SizedBox(
                              width: ScreenUtil().setSp(15),
                            ),
                            OurElevatedButton(
                              title: "Add",
                              function: () {
                                if (_product_name_controller.text.trim() !=
                                    null) {
                                  int index = Get.find<ProductController>()
                                      .productNameList
                                      .indexOf(
                                          _product_name_controller.text.trim());
                                  print(index);
                                  String id = Get.find<ProductController>()
                                      .productIDList[index];
                                  if (addedItemId.contains(id)) {
                                    OurToast()
                                        .showErrorToast("Item Already Added");
                                  } else {
                                    addedItemId.add(id);
                                    AddProductModel addProductModel =
                                        AddProductModel(
                                            batch: "",
                                            productName:
                                                _product_name_controller.text
                                                    .trim(),
                                            productId: id,
                                            qty: 1.toString(),
                                            freeQty: 1.toString());

                                    print(addProductModel.toJson());
                                    setState(() {
                                      addProductModelList.add(addProductModel);
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
                        OurSizedBox(),
                        Center(
                          child: addProductModelList.isEmpty
                              ? Text(
                                  "No Items Selected",
                                  style: TextStyle(
                                    color: darklogoColor,
                                    fontSize: ScreenUtil().setSp(17.5),
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : Column(
                                  children: [
                                    SizedBox(
                                      height: ScreenUtil().setSp(4),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: Text(
                                            "Product Name",
                                            style: TextStyle(
                                              fontSize: ScreenUtil().setSp(
                                                16.5,
                                              ),
                                              color: darklogoColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Qty",
                                            style: TextStyle(
                                              fontSize: ScreenUtil().setSp(
                                                15,
                                              ),
                                              color: darklogoColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Batch",
                                            style: TextStyle(
                                              fontSize: ScreenUtil().setSp(
                                                15,
                                              ),
                                              color: darklogoColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: darklogoColor,
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setSp(4),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: addProductModelList
                                          .map((e) => addProduct(e))
                                          .toList(),
                                    ),
                                  ],
                                ),
                        ),
                        Center(
                          child: OurElevatedButton(
                            title: "Submit",
                            function: () async {
                              List<Map<String, String>> itemListJson = [];
                              print("UTSAV");
                              addProductModelList.forEach((e) {
                                itemListJson.add(e.toStockMap());
                                print(e.toStockMap());
                              });
                              Map<String, dynamic> toJson = {
                                "entryDate": date_controller.text,
                                "products": itemListJson,
                              };
                              print("UTKRISTA");
                              print(toJson);
                              print(partyDistributerId);
                              if (itemListJson.isEmpty ||
                                  _distributer_name_controller.text.trim() ==
                                      "") {
                                OurToast().showErrorToast("Enter Data");
                              } else {
                                int index = Get.find<DistributerController>()
                                    .distnameList
                                    .indexOf(
                                      _distributer_name_controller.text.trim(),
                                    );
                                print(index);
                                String id = Get.find<DistributerController>()
                                    .distIDList[index];
                                partyDistributerId = id;
                                await APIService().addDistributerStock(
                                  toJson,
                                  partyDistributerId,
                                  context,
                                );
                              }
                              print("Utsav");
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
        });
  }

  Widget addProduct(AddProductModel e) {
    TextEditingController _batch_controller = TextEditingController();
    TextEditingController _quantity_controller = TextEditingController();

    return StatefulBuilder(builder: (context, StateSetter setState) {
      return Container(
        // Colors.white,
        color: Colors.white,
        margin: EdgeInsets.symmetric(
          vertical: ScreenUtil().setSp(5),
        ),
        padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setSp(5),
          horizontal: ScreenUtil().setSp(5),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 6,
                  child: Text(
                    e.productName,
                    style: TextStyle(
                      color: darklogoColor,
                      fontSize: ScreenUtil().setSp(15),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setSp(15),
                ),
                Expanded(
                  flex: 2,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Qty",
                      hintStyle: TextStyle(
                        fontSize: ScreenUtil().setSp(17.5),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        e.qty = value;
                      });
                    },
                    // controller: _quantity_controller,
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setSp(15),
                ),
                Expanded(
                  flex: 2,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        e.batch = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "No",
                      hintStyle: TextStyle(
                        fontSize: ScreenUtil().setSp(17.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darklogoColor,
        title: Text(
          "Distributor Stoke",
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
              StreamBuilder(
                stream: DistributerStokeController.getStoke(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data.length > 0
                        ? AnimationLimiter(
                            child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, index) {
                              CustomStokeData data = snapshot.data[index];

                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 750),
                                child: SlideAnimation(
                                  horizontalOffset: ScreenUtil().setSp(50.0),
                                  child: FadeInAnimation(
                                    child: OurDistributerStock(
                                      data: data,
                                    ),
                                  ),
                                ),
                              );
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
            _product_name_controller.text = "";
            dateoftravel = DateTime.now();
            value = null;
            distributervalue = null;
            partyDistributerId = "TEST";
            addProductModelList = [];
            addedItemId = [];
            productData = [];
          });
          openBottomSheel(context);
        },
        child: Icon(
          Icons.add,
          size: ScreenUtil().setSp(35),
        ),
      ),
    );
  }
}
