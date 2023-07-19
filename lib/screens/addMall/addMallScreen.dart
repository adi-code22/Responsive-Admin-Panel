import 'package:admin/screens/addMall/components/addMallHeader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multiselect/multiselect.dart';

import '../../constants.dart';
import '../../models/Malls.dart';
import '../../responsive.dart';
import '../main/components/alertBox.dart';
import '../main/components/textField.dart';

class AddMallScreen extends StatefulWidget {
  const AddMallScreen({Key? key}) : super(key: key);

  @override
  State<AddMallScreen> createState() => _AddMallScreenState();
}

class _AddMallScreenState extends State<AddMallScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  final websiteController = TextEditingController();
  final numberOfParkingSlotsController = TextEditingController();
  final numberOfStoresController = TextEditingController();

  List<String> selectedValues = [];
  bool errorFlag = false;

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      // primary: false,
      padding: EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          AddMallHeader(),
          SizedBox(height: defaultPadding * 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                      controller: nameController,
                      hintText: "Mall Name",
                      multiline: false,
                      context: context),
                  CustomTextField(
                      controller: emailController,
                      hintText: "Mall EMail",
                      multiline: false,
                      context: context),
                  CustomTextField(
                      controller: phoneController,
                      hintText: "Mall Phone No.",
                      multiline: false,
                      context: context),
                  CustomTextField(
                      controller: locationController,
                      hintText: "Mall Location",
                      multiline: true,
                      context: context),
                ],
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CustomTextField(
                    controller: websiteController,
                    hintText: "Mall Website",
                    multiline: false,
                    context: context),
                CustomTextField(
                    controller: numberOfStoresController,
                    hintText: "Number of Stores",
                    multiline: false,
                    context: context),
                CustomTextField(
                    controller: numberOfParkingSlotsController,
                    hintText: "Number of Parking Slots",
                    multiline: false,
                    context: context),
                CustomMultiSelectDropDown(context),
              ]),
            ],
          ),
          Column(
            children: [
              SizedBox(height: defaultPadding * 3),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  db.collection("malls").add({
                    "mallName": nameController.text,
                    "mallEmail": emailController.text,
                    "mallPhoneNumber": phoneController.text,
                    "mallLocation": locationController.text,
                    "mallWebsite": websiteController.text,
                    "numberOfStores": numberOfStoresController.text,
                    "numberOfParkingSlots": numberOfParkingSlotsController.text,
                    "typeOfStores": selectedValues,
                  }).catchError((e) {
                    errorFlag = true;
                    print("Error" + e.toString());
                    showDialog(
                      context: context,
                      builder: (context) => CustomAlertDialog(
                        msg: "Couldn't Add Mall",
                        content: e.toString(),
                      ),
                    );
                  }).whenComplete(() {
                    if (!errorFlag) {
                      print("Mall Added");
                      showDialog(
                        context: context,
                        builder: (context) =>
                            CustomAlertDialog(msg: "Mall Added Successfully"),
                      );
                      nameController.clear();
                      emailController.clear();
                      phoneController.clear();
                      locationController.clear();
                      websiteController.clear();
                      numberOfStoresController.clear();
                      numberOfParkingSlotsController.clear();
                      selectedValues.clear();
                    }
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: 60,
                  //margin: EdgeInsets.only(top: defaultPadding),
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical: defaultPadding / 2,
                  ),
                  decoration: BoxDecoration(
                    color: secondaryColor.withOpacity(0.75),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.store, color: Colors.white),
                      if (!Responsive.isMobile(context))
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding / 2),
                          child: Text("Add Mall"),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }

  Column CustomMultiSelectDropDown(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Container(
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          width: MediaQuery.of(context).size.width *
              (Responsive.isDesktop(context) ? 0.35 : 0.4),
          child: DropDownMultiSelect(
              decoration: InputDecoration(
                // contentPadding:
                //     EdgeInsets.only(left: 10, bottom: 50),
                hintText: "Type of Stores",
                fillColor: secondaryColor,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              options: ['Fashion', 'Electronics', 'Food', 'Other'],
              selectedValues: selectedValues,
              onChanged: (List<String> value) {
                setState(() {
                  selectedValues = value;
                });
              }),
        ),
      ],
    );
  }
}
