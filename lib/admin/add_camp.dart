import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:peaceful_pulse_admin/models/camp_model.dart';
import 'package:random_string/random_string.dart';

import '../constants/custom_colors.dart';
import '../database.dart';

class AddCamp extends StatefulWidget {
  const AddCamp({super.key});

  @override
  State<AddCamp> createState() => _AddCampState();
}

class _AddCampState extends State<AddCamp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  late DateTime? date;
  List<String> centerNames = [];
  List<Map<String, dynamic>> centerList = [];
  String center = "";

  Future<void> dateSelect(BuildContext context) async {
    final DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    if (newSelectedDate != null) {
      setState(() {
        dateController.text = newSelectedDate.toString().split(" ")[0];
      });
    }
  }

  @override
  void initState() {
    date = DateTime(2023, 5, 21);
    super.initState();
  }

  Future callingCenters() async {
    centerNames = [];

    final snapshotCen = await DataBaseMethods().getCenterDetails();
    for (var doc in snapshotCen.docs) {
      centerList.add(doc.data());
      centerNames.add(doc["Name"]);
    }
    center = centerNames.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: CustomColors.primaryColor,
        child: Row(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 2,
              child: ColoredBox(
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 450,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          "Add camp details",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: locationController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              hintText: "Camp Location",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          style: const TextStyle(
                              color: CustomColors.secondaryColor),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FutureBuilder(
                            future: callingCenters(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting){
                                return const Center(child: CircularProgressIndicator());
                              }
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: DropdownMenu<String>(
                                  initialSelection: centerNames.first,
                                  onSelected: (String? value) {
                                    setState(() {
                                      center = value!;
                                    });
                                  },
                                  dropdownMenuEntries: centerNames
                                      .map<DropdownMenuEntry<String>>(
                                          (String value) {
                                    return DropdownMenuEntry<String>(
                                        value: value, label: value);
                                  }).toList(),
                                ),
                              );
                            }),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              hintText: "Phone Number",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          style: const TextStyle(
                              color: CustomColors.secondaryColor),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: dateController,
                          validator: (date) {
                            if (date == null || date.isEmpty) {
                              return 'Please enter a date';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Date in YYYY-MM-DD',
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              suffixIcon: IconButton(
                                  onPressed: () => dateSelect(context),
                                  icon: const Icon(
                                    CupertinoIcons.calendar,
                                    color: CustomColors.secondaryColor,
                                  ))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      String id = randomAlphaNumeric(10);
                                      // CampModel campInfo = CampModel(
                                      //     center: centerNameController.text,
                                      //     campDate: dateController.text,
                                      //     phoneNumber: phoneController.text,
                                      //     location: locationController.text);
                                      Map<String, dynamic> campInfoMap = {
                                        "Location": locationController.text,
                                        "Date": dateController.text,
                                        "Phone": phoneController.text,
                                        "Center Name":
                                            center,
                                        "id": id
                                      };
                                      await DataBaseMethods()
                                          .addCamps(campInfoMap, id)
                                          .then((value) {
                                        Fluttertoast.showToast(
                                                msg:
                                                    "Data Uploaded Successfully",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.grey,
                                                textColor: Colors.white,
                                                fontSize: 16.0)
                                            .then((value) =>
                                                Navigator.pop(context));
                                      });
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.white),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      "Add",
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
