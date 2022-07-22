import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/models/login_response_model.dart';
import 'package:myapp/screens/authentication_screens/login_screen.dart';

import '../../db/db_helper.dart';
import '../main_screens/dashboard_screen.dart';

class OuterLayerScreen extends StatefulWidget {
  const OuterLayerScreen({Key? key}) : super(key: key);

  @override
  _OuterLayerScreenState createState() => _OuterLayerScreenState();
}

class _OuterLayerScreenState extends State<OuterLayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable:
            Hive.box<String>(DatabaseHelper.authenticationDB).listenable(),
        builder: (context, Box<String> boxs, child) {
          String value = boxs.get("state", defaultValue: "")!;
          print("===========");
          print(value);
          print("===========");
          return value == "" ? LoginScreen() : const DashBoardScreen();
        },
      ),
    );
  }
}
