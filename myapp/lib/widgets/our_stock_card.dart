import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/widgets/our_sized_box.dart';

import '../models/custom_stoke.dart';
import '../utils/color.dart';

class OurDistributerStock extends StatelessWidget {
  final CustomStokeData data;
  const OurDistributerStock({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: ScreenUtil().setSp(7.5),
        right: ScreenUtil().setSp(7.5),
        bottom: ScreenUtil().setSp(7.5),
      ),
      padding: EdgeInsets.only(
        // left: ScreenUtil().setSp(10),
        // right: ScreenUtil().setSp(10),
        bottom: ScreenUtil().setSp(10),
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(ScreenUtil().setSp(20)),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: logoColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ScreenUtil().setSp(20)),
                topRight: Radius.circular(ScreenUtil().setSp(20)),
              ),
            ),
            width: double.infinity,
            height: ScreenUtil().setSp(40),
            child: Center(
              child: Text(
                data.distributor ?? "",
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(20),
                  color: Colors.white,
                ),
              ),
            ),
          ),
          OurSizedBox(),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setSp(10),
              vertical: ScreenUtil().setSp(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Stock ID:",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: logoColor,
                            fontSize: ScreenUtil().setSp(17.5),
                          ),
                        ),
                        OurSizedBox(),
                        Text(
                          data.stokeId ?? "",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(15),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "State date:",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: logoColor,
                            fontSize: ScreenUtil().setSp(17.5),
                          ),
                        ),
                        OurSizedBox(),
                        Text(
                          data.statedate ?? "",
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Distributor:",
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
                        data.distributor ?? "",
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
                  children: data.meta!
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
                                  e.product.toString(),
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
                                  "Rs\t${e.price.toString()}",
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
            ),
          )
        ],
      ),
    );
  }
}
