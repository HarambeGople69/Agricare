import 'package:flutter/material.dart';
import 'package:flutter_dropdown_search/flutter_dropdown_search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:myapp/api_services/api_service.dart';
import 'package:myapp/controller/product_controller.dart';
import 'package:myapp/controller/retrailer_controller.dart';
import 'package:myapp/models/distributer_order_load_model.dart';
import 'package:myapp/screens/main_screens/retailer_order_load_screen.dart';
import 'package:myapp/widgets/our_distributer_order_load_card.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import 'package:intl/intl.dart';
import 'package:myapp/widgets/our_flutter_toast.dart';

import '../../controller/distributer_controller.dart';
import '../../controller/distributer_order_load_controller.dart';
import '../../controller/search_text_controller.dart';
import '../../models/add_product_model.dart';
import '../../models/product_model.dart';
import '../../utils/color.dart';
import '../../widgets/our_sized_box.dart';
import '../../widgets/our_spinner.dart';

class OurDistributerOrderLoad extends StatefulWidget {
  const OurDistributerOrderLoad({Key? key}) : super(key: key);

  @override
  State<OurDistributerOrderLoad> createState() =>
      _OurDistributerOrderLoadState();
}

class _OurDistributerOrderLoadState extends State<OurDistributerOrderLoad> {
  TextEditingController _order_date = TextEditingController();
  TextEditingController _delivery_date = TextEditingController();
  TextEditingController _product_name_controller = TextEditingController();
  TextEditingController _distributer_name_controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    Get.find<SearchTextController>().clearController();
    setState(() {
      _order_date.text =
          "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}";
      _delivery_date.text =
          "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}";
    });
  }

  void fetchData() async {
    await APIService().listofProduct();
    await APIService().listofdistributer();
  }

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
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  "Add New Distributer Order",
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
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Order Date:",
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
                                    readOnly: true,
                                    onTap: () async {
                                      late DateTime dateTime;
                                      DateTime initialTime = DateTime.now();
                                      DateTime? date = await showDatePicker(
                                        context: context,
                                        // helpText:"Help",
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2222),
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
                                        //  = dateTime;
                                        _order_date.text =
                                            "${dateTime.year}/${dateTime.month}/${dateTime.day}";
                                        // print(date_controller);
                                      });
                                    },
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(17),
                                      color: logoColor,
                                    ),
                                    controller: _order_date,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: "Order Date",
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
                                    "Delivery Date:",
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
                                    readOnly: true,
                                    onTap: () async {
                                      late DateTime dateTime;
                                      DateTime initialTime = DateTime.now();
                                      DateTime? date = await showDatePicker(
                                        context: context,
                                        // helpText:"Help",
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2222),
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
                                        //  = dateTime;
                                        _delivery_date.text =
                                            "${dateTime.year}/${dateTime.month}/${dateTime.day}";
                                        // print(date_controller);
                                      });
                                    },
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(17),
                                      color: logoColor,
                                    ),
                                    controller: _delivery_date,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: "Delivery Date",
                                    ),
                                  ),
                                ],
                              ),
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
                        OurSizedBox(),
                        Row(
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
                                      .indexOf(_product_name_controller.text);
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
                                              "FQty",
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
                                            .map((e) => Container(
                                                  // Colors.white,
                                                  color: Colors.white,
                                                  margin: EdgeInsets.symmetric(
                                                    vertical:
                                                        ScreenUtil().setSp(5),
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        ScreenUtil().setSp(5),
                                                    horizontal:
                                                        ScreenUtil().setSp(5),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            flex: 6,
                                                            child: Text(
                                                              e.productName,
                                                              style: TextStyle(
                                                                color:
                                                                    darklogoColor,
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            15),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: ScreenUtil()
                                                                .setSp(15),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: TextField(
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText: "Qty",
                                                                hintStyle:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              17.5),
                                                                ),
                                                              ),
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  e.qty = value;
                                                                });
                                                              },
                                                              // controller: _quantity_controller,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: ScreenUtil()
                                                                .setSp(15),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: TextField(
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "FQty",
                                                                hintStyle:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              17.5),
                                                                ),
                                                              ),
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  e.freeQty =
                                                                      value;
                                                                });
                                                              },
                                                              // controller: _quantity_controller,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                    ],
                                  )),
                        OurSizedBox(),
                        Center(
                          child: OurElevatedButton(
                            title: "Submit",
                            function: () async {
                              List<Map<String, String>> itemListJson = [];
                              print("hello World");
                              // print(addProductModelList);
                              print("UtsavUtkrista");
                              addProductModelList.forEach((element) {
                                itemListJson.add(element.toMap());
                                // print(element.toMap());
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
                              print(itemListJson);
                              if (itemListJson.isEmpty ||
                                  _distributer_name_controller.text.trim() ==
                                      "") {
                                OurToast().showErrorToast("Enter Data");
                              } else {
                                Map<String, dynamic> toJson = {
                                  "orderDate": _order_date.text.trim(),
                                  "distributor": partyDistributerId,
                                  "deliveryDate": _delivery_date.text.trim(),
                                  "products": itemListJson,
                                };
                                print(toJson);
                                await APIService().adddistributerOrder(
                                  toJson,
                                  partyDistributerId,
                                );
                                Navigator.pop(context);
                                print("object 1");
                                print(toJson);
                                print(partyDistributerId);
                                print("object 2");
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
        });
  }

  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darklogoColor,
        title: Text(
          "Distributer Order Load",
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
                      print("object");
                      Get.find<SearchTextController>().changeValue(value);
                      setState(() {
                        searchText =
                            Get.find<SearchTextController>().searchText.value;
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
                      hintText: "Search by distributer",
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
                stream: DistributerOrcerController.getVisitPlan(),
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
                                  DistributerorderloadData data =
                                      snapshot.data[index];
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 750),
                                    child: SlideAnimation(
                                      horizontalOffset:
                                          ScreenUtil().setSp(50.0),
                                      child: FadeInAnimation(
                                        child: OurDistribterOrderLoadCard(
                                            data: data),
                                      ),
                                    ),
                                  );
                                  // return OurDistribterOrderLoadCard(data: data);
                                },
                              ))
                            : AnimationLimiter(
                                child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, index) {
                                  DistributerorderloadData data =
                                      snapshot.data[index];
                                  // return Text(searchText);
                                  return data.distName!
                                          .toLowerCase()
                                          .contains(searchText.toLowerCase())
                                      ? AnimationConfiguration.staggeredList(
                                          position: index,
                                          duration:
                                              const Duration(milliseconds: 750),
                                          child: SlideAnimation(
                                            horizontalOffset:
                                                ScreenUtil().setSp(50.0),
                                            child: FadeInAnimation(
                                                child:
                                                    OurDistribterOrderLoadCard(
                                                        data: data)),
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
            _product_name_controller.text = "";
            _distributer_name_controller.text = "";
            value = null;
            addProductModelList = [];
            partyDistributerId = "TEST";
            addedItemId = [];
            distributervalue = null;
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
