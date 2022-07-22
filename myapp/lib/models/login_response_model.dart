import 'package:hive_flutter/adapters.dart';
part 'login_response_model.g.dart';

@HiveType(typeId: 0)
class loginResponseModel extends HiveObject {
  @HiveField(0)
  dynamic? error;
  @HiveField(1)
  dynamic? status;
  @HiveField(2)
  dynamic? token;
  @HiveField(3)
  dynamic? success;
  @HiveField(4)
  dynamic? userName;
  @HiveField(5)
  dynamic? userId;
  @HiveField(6)
  dynamic? usertype;

  loginResponseModel(
      {this.error,
      this.status,
      this.token,
      this.success,
      this.userName,
      this.userId,
      this.usertype});

  loginResponseModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    status = json['status'];
    token = json['token'];
    success = json['success'];
    userName = json['user_name'];
    userId = json['user_id'];
    usertype = json['usertype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['status'] = this.status;
    data['token'] = this.token;
    data['success'] = this.success;
    data['user_name'] = this.userName;
    data['user_id'] = this.userId;
    data['usertype'] = this.usertype;
    return data;
  }
}
