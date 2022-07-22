import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/utils/color.dart';

import 'our_sized_box.dart';

class OurDashBoardScreenTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  final Function function;
  const OurDashBoardScreenTile(
      {Key? key,
      required this.title,
      required this.imageUrl,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                ScreenUtil().setSp(17.5),
              ),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setSp(10),
              vertical: ScreenUtil().setSp(7),
            ),
            // margin: EdgeInsets.symmetric(
            //   horizontal: ScreenUtil().setSp(5),
            //   // vertical: ScreenUtil().setSp(5),
            // ),
            child: Image.asset(
              imageUrl,
              width: ScreenUtil().setSp(50),
              height: ScreenUtil().setSp(50),
            ),
          ),
          OurSizedBox(),
          Text(
            title,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(15),
              fontWeight: FontWeight.w600,
              color: darklogoColor,
            ),
          )
        ],
      ),
    );
  }
}
