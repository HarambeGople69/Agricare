import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/retailer_order_load_model.dart';
import '../utils/color.dart';
import 'our_sized_box.dart';

class OurRetailerOrderCard extends StatelessWidget {
  final Retailerlistdata data;
  const OurRetailerOrderCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setSp(7.5),
          vertical: ScreenUtil().setSp(7.5),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setSp(10),
          vertical: ScreenUtil().setSp(10),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            ScreenUtil().setSp(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivery Date",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: logoColor,
                        fontSize: ScreenUtil().setSp(17.5),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setSp(5),
                    ),
                    Text(
                      data.deliveryDate ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenUtil().setSp(15),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Date",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: logoColor,
                        fontSize: ScreenUtil().setSp(17.5),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setSp(5),
                    ),
                    Text(
                      data.orderDate ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenUtil().setSp(15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            OurSizedBox(),
            Row(
              // crossAxisAlignment:
              //     CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Order No:",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: logoColor,
                    fontSize: ScreenUtil().setSp(17.5),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setSp(7.5),
                ),
                Expanded(
                  child: Text(
                    data.orderNo ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: ScreenUtil().setSp(15),
                    ),
                  ),
                ),
              ],
            ),
            OurSizedBox(),
            Row(
              // crossAxisAlignment:
              //     CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Distributer name:",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: logoColor,
                    fontSize: ScreenUtil().setSp(17.5),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setSp(7.5),
                ),
                Expanded(
                  child: Text(
                    data.distName ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: ScreenUtil().setSp(15),
                    ),
                  ),
                ),
              ],
            ),
            OurSizedBox(),
            Row(
              // crossAxisAlignment:
              //     CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Retailer name:",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: logoColor,
                    fontSize: ScreenUtil().setSp(17.5),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setSp(7.5),
                ),
                Expanded(
                  child: Text(
                    data.retailName ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: ScreenUtil().setSp(15),
                    ),
                  ),
                ),
              ],
            ),
            OurSizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Total amount:",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: logoColor,
                    fontSize: ScreenUtil().setSp(17.5),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setSp(7.5),
                ),
                Expanded(
                  child: Text(
                    data.totalAmount ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: ScreenUtil().setSp(15),
                    ),
                  ),
                ),
              ],
            ),
            OurSizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Discount Amount:",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: logoColor,
                    fontSize: ScreenUtil().setSp(17.5),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setSp(7.5),
                ),
                Expanded(
                  child: Text(
                    data.discountAmount ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: ScreenUtil().setSp(15),
                    ),
                  ),
                ),
              ],
            ),
            OurSizedBox(),
            Row(
              // crossAxisAlignment:
              //     CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Vat:",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: logoColor,
                    fontSize: ScreenUtil().setSp(17.5),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setSp(7.5),
                ),
                Expanded(
                  child: Text(
                    data.vat ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: ScreenUtil().setSp(15),
                    ),
                  ),
                ),
              ],
            ),
            OurSizedBox(),
            Row(
              // crossAxisAlignment:
              //     CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Net Amount:",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: logoColor,
                    fontSize: ScreenUtil().setSp(17.5),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setSp(7.5),
                ),
                Expanded(
                  child: Text(
                    data.netamount ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: ScreenUtil().setSp(15),
                    ),
                  ),
                ),
              ],
            ),
            OurSizedBox(),
            ExpansionTile(
              title: Text(
                "Items:",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: logoColor,
                  fontSize: ScreenUtil().setSp(17.5),
                ),
              ),
              children: data.items!
                  .map(
                    (e) => Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setSp(5),
                        vertical: ScreenUtil().setSp(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              e.productName.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: ScreenUtil().setSp(15),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Quantity\t${e.qty.toString()}",
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(17),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Rs\t${e.amount.toString()}",
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(17),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ));
    ;
  }
}
