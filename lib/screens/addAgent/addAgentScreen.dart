import 'package:admin/screens/addAgent/components/addAgentHeader.dart';
import 'package:admin/screens/main/components/dynamicDropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../responsive.dart';
import '../main/components/alertBox.dart';
import '../main/components/textField.dart';

class AddAgentScreen extends StatefulWidget {
  const AddAgentScreen({Key? key}) : super(key: key);

  @override
  State<AddAgentScreen> createState() => _AddAgentScreenState();
}

class _AddAgentScreenState extends State<AddAgentScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  final availableTimingsController = TextEditingController();

  final ValueNotifier<String?> dropdownNotifier = ValueNotifier(null);

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
          AddAgentHeader(),
          SizedBox(height: defaultPadding * 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                      controller: nameController,
                      hintText: "Agent Name",
                      multiline: false,
                      context: context),
                  CustomTextField(
                      controller: emailController,
                      hintText: "Agent EMail",
                      multiline: false,
                      context: context),
                  CustomTextField(
                      controller: phoneController,
                      hintText: "Agent Phone No.",
                      multiline: false,
                      context: context),
                  CustomTextField(
                      controller: locationController,
                      hintText: "Agent Location",
                      multiline: true,
                      context: context),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                      controller: availableTimingsController,
                      hintText: "Available Timings",
                      multiline: false,
                      context: context),
                  MessageList(firestore: db, valueNotifier: dropdownNotifier),
                  // CustomTextField(
                  //     controller: nameController,
                  //     hintText: "Name",
                  //     multiline: false,
                  //     context: context),
                  // CustomTextField(
                  //     controller: nameController,
                  //     hintText: "Name",
                  //     multiline: false,
                  //     context: context),
                ],
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: defaultPadding * 3),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  db.collection("agents").add({
                    "agentName": nameController.text,
                    "agentEmail": emailController.text,
                    "agentPhoneNumber": phoneController.text,
                    "agentLocation": locationController.text,
                    "mallName": dropdownNotifier.value,
                    "availableTiming": availableTimingsController.text,
                  }).catchError((e) {
                    errorFlag = true;
                    print("Error" + e.toString());
                    showDialog(
                      context: context,
                      builder: (context) => CustomAlertDialog(
                        msg: "Couldn't Add Agent",
                        content: e.toString(),
                      ),
                    );
                  }).whenComplete(() {
                    if (!errorFlag) {
                      print("Agent Added");
                      showDialog(
                        context: context,
                        builder: (context) =>
                            CustomAlertDialog(msg: "Agent Added Successfully"),
                      );
                      nameController.clear();
                      emailController.clear();
                      phoneController.clear();
                      locationController.clear();
                      availableTimingsController.clear();
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
                          child: Text("Add Agent"),
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
}
