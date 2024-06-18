
import 'package:peaceful_pulse_admin/models/doctor_model.dart';

class CampModel {
  String centerName;
  String location;
  String date;
  String phoneNumber;
  String id;
  DoctorModel doctor;

  CampModel({
    required this.centerName,
    required this.location,
    required this.date,
    required this.phoneNumber,
    required this.id,
    required this.doctor
  });
  factory CampModel.fromMap(Map<String, dynamic> map) {
    return CampModel(
        centerName: map['centerName'],
        location: map['location'],
        date: map['date'],
        phoneNumber: map['phoneNumber'],
        id: map['id'],
        doctor: map['doctor']);
  }
  Map<String, dynamic> toMap() {
    return {
      'centerName': centerName,
      'location': location,
      'date': date,
      'phoneNumber': phoneNumber,
      'id': id,
      'doctor': doctor
    };
  }
}
