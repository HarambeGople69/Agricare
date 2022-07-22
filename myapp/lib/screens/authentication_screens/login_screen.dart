/*
* File : Shopping Login
* Version : 1.0.0
* */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myapp/api_services/api_service.dart';
import 'package:myapp/utils/color.dart';
import 'package:myapp/widgets/our_password_field.dart';
import 'package:page_transition/page_transition.dart';

import '../../controller/login_controller.dart';
import '../../widgets/our_elevated_button.dart';
import '../../widgets/our_flutter_toast.dart';
import '../../widgets/our_sized_box.dart';
import '../../widgets/our_spinner.dart';
import '../../widgets/our_text_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  FocusNode _username_node = FocusNode();
  FocusNode _password_node = FocusNode();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _username.clear();
    _username.dispose();
    _password.clear();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgressHUD(
          inAsyncCall: Get.find<LoginController>().processing.value,
          progressIndicator: OurSpinner(),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              body: SafeArea(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setSp(10),
                    vertical: ScreenUtil().setSp(10),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                        ),
                        OurSizedBox(),
                        Image.asset(
                          "assets/images/icon.jpg",
                          fit: BoxFit.contain,
                          height: ScreenUtil().setSp(200),
                          width: ScreenUtil().setSp(200),
                        ),
                        OurSizedBox(),
                        Text(
                          "Agricare",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(27.5),
                            color: darklogoColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        OurSizedBox(),
                        OurSizedBox(),
                        OurSizedBox(),
                        CustomTextField(
                          start: _username_node,
                          end: _password_node,
                          icon: Icons.person,
                          controller: _username,
                          validator: (value) {},
                          title: "Username",
                          type: TextInputType.name,
                          number: 0,
                        ),
                        OurSizedBox(),
                        PasswordForm(
                          start: _password_node,
                          controller: _password,
                          validator: (value) {},
                          title: "Password",
                          // type: TextInputType.name,
                          number: 1,
                        ),
                        // CustomTextField(
                        // controller: _username,
                        // validator: (value) {},
                        // title: "Username",
                        // type: TextInputType.name,
                        // number: 1,
                        // ),
                        OurSizedBox(),
                        Container(
                          height: ScreenUtil().setSp(40),
                          margin: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setSp(22.5),
                          ),
                          width: double.infinity,
                          child: OurElevatedButton(
                            title: "Login",
                            function: () async {
                              if (_username.text.trim().isEmpty ||
                                  _password.text.trim().isEmpty) {
                                OurToast()
                                    .showErrorToast("Field can't be empty");
                              } else {
                                //  username,password
                                var jsons = {
                                  "username": _username.text.trim(),
                                  "password": _password.text.trim(),
                                };
                                print(jsons);
                                await APIService().login(jsons, context);
                                //  var appSignatureID =
                                //     await SmsAutoFill().getAppSignature;
                                print("==========");
                                print("==========");
                                print("==========");
                                print("==========");
                                // print(appSignatureID);
                                print("==========");
                                print("==========");
                                print("==========");
                                print("==========");
                                // await PhoneAuth().sendLoginOTP(
                                //   _phone_number_controller.text.trim(),
                                //   context,
                                // );
                              }
                            },
                          ),
                        ),
                        OurSizedBox(),
                        // Center(
                        //   child: FxButton.text(
                        //     onPressed: () async {
                        //       Navigator.push(
                        //         context,
                        //         PageTransition(
                        //           type: PageTransitionType.leftToRight,
                        //           child: ShoppingRegisterScreen(),
                        //         ),
                        //       );
                        //       // MaterialPageRoute(
                        //       // builder: (context) => ShoppingRegisterScreen()));
                        //     },
                        //     child: FxText.b2(
                        //       "I don't have an account",
                        //       decoration: TextDecoration.underline,
                        //       fontSize: ScreenUtil().setSp(15),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
