import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/models/tada_model_response.dart';
import 'package:myapp/widgets/our_sized_box.dart';

import '../utils/color.dart';

class OurTadaCard extends StatelessWidget {
  final dataa tada_mode_response;
  const OurTadaCard({Key? key, required this.tada_mode_response})
      : super(key: key);

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
          )),
      // child: Text("UTsav"),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Date:",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: logoColor,
                  fontSize: ScreenUtil().setSp(17.5),
                ),
              ),
              SizedBox(
                width: ScreenUtil().setSp(7.5),
              ),
              Text(
                tada_mode_response.date ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenUtil().setSp(15),
                ),
              ),
            ],
          ),
          OurSizedBox(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "KMs:",
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
                  tada_mode_response.meta!.kmcovered ?? "",
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
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "TA:",
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
                        "Rs. ${tada_mode_response.ta ?? ''}",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "DA:",
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
                        "Rs. ${tada_mode_response.da ?? ""}",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(15),
                        ),
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "From:",
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
                        "${tada_mode_response.meta!.startLocation ?? ""}",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "To:",
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
                        "${tada_mode_response.meta!.stopLocation ?? ''}",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          OurSizedBox(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Party:",
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
                  tada_mode_response.meta!.party ?? "",
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Total:",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: logoColor,
                  fontSize: ScreenUtil().setSp(17.5),
                ),
              ),
              SizedBox(
                width: ScreenUtil().setSp(7.5),
              ),
              Text(
                "${double.parse(tada_mode_response.ta ?? '') + double.parse(tada_mode_response.da ?? '')}",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenUtil().setSp(15),
                ),
              ),
            ],
          ),
          OurSizedBox(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Retailers:",
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
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: tada_mode_response.meta!.retailers!
                    .map((e) => Text(
                          e,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(15),
                          ),
                        ))
                    .toList(),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
