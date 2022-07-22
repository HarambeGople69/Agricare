import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
part 'attendance_model.g.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first
@HiveType(typeId: 1)

class AttendanceModel extends HiveObject{
  @HiveField(0)
  String mr;
  @HiveField(1)
  String longitude;
  @HiveField(2)
  String latitude;
  @HiveField(3)
  String signal;
  @HiveField(4)
  String stamp_time;
  AttendanceModel({
    required this.mr,
    required this.longitude,
    required this.latitude,
    required this.signal,
    required this.stamp_time,
  });

  AttendanceModel copyWith({
    String? mr,
    String? longitude,
    String? latitude,
    String? signal,
    String? stamp_time,
  }) {
    return AttendanceModel(
      mr: mr ?? this.mr,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      signal: signal ?? this.signal,
      stamp_time: stamp_time ?? this.stamp_time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mr': mr,
      'longitude': longitude,
      'latitude': latitude,
      'signal': signal,
      'stamp_time': stamp_time,
    };
  }

  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      mr: map['mr'] as String,
      longitude: map['longitude'] as String,
      latitude: map['latitude'] as String,
      signal: map['signal'] as String,
      stamp_time: map['stamp_time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AttendanceModel.fromJson(String source) => AttendanceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
