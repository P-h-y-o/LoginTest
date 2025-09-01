import 'package:loginpage/user_data_model/user_attendance.dart';
import 'package:loginpage/user_data_model/user_info.dart';

class PersonalData {
  final Info info;
  final Attendance attendance;

  PersonalData({required this.info, required this.attendance});

  factory PersonalData.fromJson(Map<String, dynamic> json) {
    return PersonalData(
      info: Info.fromJson(json['info']),
      attendance: Attendance.fromJson(json['attendance']),
    );
  }
}
