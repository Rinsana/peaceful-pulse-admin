import 'package:peaceful_pulse_admin/models/center_model.dart';

class CampModel {
  final String center;
  final String campDate;
  final String phoneNumber;
  final String location;

  CampModel(
      {required this.center,
      required this.campDate,
      required this.phoneNumber,
      required this.location});

  factory CampModel.fromJson(Map<String, dynamic> json) {
    return CampModel(center: json['center'], campDate: json['campDate'], phoneNumber: json['phoneNumber'], location: json['location']);
  }

  Map<String, dynamic> toJson() {
    return {
      'center': center,
      'campDate': campDate,
      'location': location,
      'phoneNumber': phoneNumber,
    };
  }
}
