import 'package:flutter/material.dart';
import 'package:flutter_dropdown_search/flutter_dropdown_search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/product_controller.dart';
import 'package:myapp/utils/color.dart';

import '../../api_services/api_service.dart';

class DistributerRelationScreen extends StatefulWidget {
  const DistributerRelationScreen({Key? key}) : super(key: key);

  @override
  State<DistributerRelationScreen> createState() =>
      _DistributerRelationScreenState();
}

class _DistributerRelationScreenState extends State<DistributerRelationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    await APIService().listofProduct();

    await APIService().listofdistributer();
  }

  TextEditingController _controller = TextEditingController();
  List<String> items = [
    "Afghanistan",
    "Albania",
    "Algeria",
    "American Samoa",
    "Andorra",
    "Angola",
    "Anguilla",
    "Antarctica",
    "Antigua and Barbuda",
    "Argentina",
    "Armenia",
    "Aruba",
    "Australia",
    "Austria",
    "Azerbaijan"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Dropdown Search'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            FlutterDropdownSearch(
              hintText: "Product",
              hintStyle: TextStyle(
                fontSize: ScreenUtil().setSp(17.5),
                fontWeight: FontWeight.w400,
                // color: logoColor,
              ),
              style: TextStyle(
                fontSize: ScreenUtil().setSp(17.5),
                fontWeight: FontWeight.w500,
                // color: logoColor,
              ),
              textController: _controller,
              items: Get.find<ProductController>().productNameList,
              dropdownHeight: 300,
            )
          ],
        ),
      ),
    );
  }
}
