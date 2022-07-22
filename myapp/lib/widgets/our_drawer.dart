import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/db/db_helper.dart';
import 'package:myapp/models/login_response_model.dart';
import 'package:myapp/widgets/our_sized_box.dart';

import '../utils/color.dart';
import 'our_elevated_button.dart';

class OurDrawer extends StatelessWidget {
  const OurDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0.0),
        children: [
          ValueListenableBuilder(
            valueListenable:
                Hive.box<loginResponseModel>("userprofileDB").listenable(),
            builder: (context, Box<loginResponseModel> boxs, child) {
              loginResponseModel loginResponse = boxs.get("currentUser")!;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: logoColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setSp(10),
                      vertical: ScreenUtil().setSp(10),
                    ),
                    margin: EdgeInsets.zero,
                    height: ScreenUtil().setSp(175),
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: ScreenUtil().setSp(25),
                            backgroundColor: darklogoColor,
                            child: Text(
                              loginResponse.userName[0].toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(25),
                              ),
                            ),
                          ),
                          OurSizedBox(),
                          Text(
                            loginResponse.userName,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(17.5),
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  OurSizedBox(),
                  Center(
                    child: OurElevatedButton(
                      function: () async {
                        // var a = Hive.box<loginResponseModel>("userprofileDB")
                        //     .get("currentUser")!
                        //     .token;
                        // print(a);
                        final service = FlutterBackgroundService();
                        var isRunning = await service.isRunning();
                        if (isRunning) {
                          service.invoke("stopService");
                        }
                        await Hive.box<String>(DatabaseHelper.authenticationDB)
                            .clear();
                      },
                      title: "Logout",
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
