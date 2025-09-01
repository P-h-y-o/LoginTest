class Attendance {
  final Null log;
  final Null lateMins;
  final bool isCheckOut;

  Attendance({
    required this.log,
    required this.lateMins,
    required this.isCheckOut,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      log: json['log'],
      lateMins: json['lateMins'],
      isCheckOut: json['isCheckOut'],
    );
  }
}
