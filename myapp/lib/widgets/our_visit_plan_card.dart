import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/models/visit_plan_model.dart';

import '../utils/color.dart';
import 'our_sized_box.dart';

class OurVisitPlanCard extends StatelessWidget {
  final VisitPlanDataa data;
  const OurVisitPlanCard({Key? key, required this.data}) : super(key: key);

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Scheduled Date",
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
                    data.date ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: ScreenUtil().setSp(15),
                    ),
                  )
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
                  data.party ?? "",
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        data.from ?? "",
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
                      "Visit To:",
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
                        data.to ?? "",
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
                children: data.retailers!
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
