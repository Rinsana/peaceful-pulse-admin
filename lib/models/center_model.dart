class CenterModel {
  final String centerName;
  final String doctorName;
  final String volunteerName;

  CenterModel(
      {required this.centerName,
      required this.doctorName,
      required this.volunteerName});

  factory CenterModel.fromJson(Map<String, dynamic> json) {
    return CenterModel(
        centerName: json['centerName'],
        doctorName: json['doctorName'],
        volunteerName: json['volunteerName']);
  }

   Map<String, dynamic> toJson(){
    return{
      "centerName": centerName,
      "doctorName":doctorName,
      "volunteerName":volunteerName,
  };
}
}
