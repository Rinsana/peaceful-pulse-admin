class DoctorModel {
  String name;
  String eMail;
  String designation;
  // String phoneNumber;
  String password;
  String image;
  String id;

  DoctorModel({
    required this.name,
    required this.eMail,
    required this.designation,
    // required this.phoneNumber,
    required this.password,
    required this.image,
    required this.id,
  });
  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
        name: map['name'],
        eMail: map['eMail'],
        designation: map['designation'],
        // phoneNumber: map['phoneNumber'],
        password: map['password'],
        image: map['image'],
        id: map['id']);
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'eMail': eMail,
      'designation': designation,
      // 'phoneNumber': phoneNumber,
      'password': password,
      'image': image,
      'id': id,
    };
  }
}
