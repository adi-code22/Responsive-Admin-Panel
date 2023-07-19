import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multiselect/multiselect.dart';

import '../../constants.dart';
import '../../models/Malls.dart';
import '../../responsive.dart';
import '../main/components/alertBox.dart';
import '../main/components/dynamicDropdown.dart';
import '../main/components/textField.dart';
import 'components/addStoreHeader.dart';

class AddStoreScreen extends StatefulWidget {
  const AddStoreScreen({Key? key}) : super(key: key);

  @override
  State<AddStoreScreen> createState() => _AddStoreScreenState();
}

class _AddStoreScreenState extends State<AddStoreScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  final websiteController = TextEditingController();
  final hoursOfOperationController = TextEditingController();
  final floorNumberController = TextEditingController();

  List<String> selectedValues = [];
  bool errorFlag = false;

  FirebaseFirestore db = FirebaseFirestore.instance;
  final ValueNotifier<String?> dropDownNotifier = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      // primary: false,
      padding: EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          AddStoreHeader(),
          SizedBox(height: defaultPadding * 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                      controller: nameController,
                      hintText: "Store Name",
                      multiline: false,
                      context: context),
                  CustomTextField(
                      controller: emailController,
                      hintText: "Store EMail",
                      multiline: false,
                      context: context),
                  CustomTextField(
                      controller: phoneController,
                      hintText: "Store Phone No.",
                      multiline: false,
                      context: context),
                  CustomTextField(
                      controller: locationController,
                      hintText: "Store Location",
                      multiline: true,
                      context: context),
                ],
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CustomTextField(
                    controller: websiteController,
                    hintText: "Store Website",
                    multiline: false,
                    context: context),
                CustomTextField(
                    controller: floorNumberController,
                    hintText: "Floor Number",
                    multiline: false,
                    context: context),
                CustomTextField(
                    controller: hoursOfOperationController,
                    hintText: "Hours of Operation",
                    multiline: false,
                    context: context),
                MessageList(firestore: db, valueNotifier: dropDownNotifier),
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
                  db.collection("shops").add({
                    "shopName": nameController.text,
                    "shopEmail": emailController.text,
                    "shopPhoneNumber": phoneController.text,
                    "shopLocation": locationController.text,
                    "shopWebsite": websiteController.text,
                    "floorNumber": floorNumberController.text,
                    "hoursOfOperation": hoursOfOperationController.text,
                    "nameOfMall": dropDownNotifier.value,
                    "products": selectedValues,
                  }).catchError((e) {
                    errorFlag = true;
                    print("Error" + e.toString());
                    showDialog(
                      context: context,
                      builder: (context) => CustomAlertDialog(
                        msg: "Couldn't Add Store",
                        content: e.toString(),
                      ),
                    );
                  }).whenComplete(() {
                    if (errorFlag == false) {
                      print("Store Added");
                      showDialog(
                        context: context,
                        builder: (context) =>
                            CustomAlertDialog(msg: "Store Added Successfully"),
                      );
                      nameController.clear();
                      emailController.clear();
                      phoneController.clear();
                      locationController.clear();
                      websiteController.clear();
                      floorNumberController.clear();
                      hoursOfOperationController.clear();
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
                          child: Text("Add Store"),
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
                hintText: "Product",
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
