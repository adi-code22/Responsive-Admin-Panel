import 'package:flutter/material.dart';

class Malls {
  String? mallName, mallEmail, mallPhoneNumber, mallLocation, mallWebsite;
  int? numberOfStores, numberOfParkingSlots;
  List<String>? typeOfStores;

  Malls({
    required String mallName,
    required String mallEmail,
    required String mallPhoneNumber,
    required String mallLocation,
    required String mallWebsite,
    required int numberOfStores,
    required int numberOfParkingSlots,
    required List<String> typeOfStores,
  });

  Map<String, dynamic> toJson() {
    return {
      "mallName": mallName,
      "mallEmail": mallEmail,
      "mallPhoneNumber": mallPhoneNumber,
      "mallLocation": mallLocation,
      "mallWebsite": mallWebsite,
      "numberOfStores": numberOfStores,
      "numberOfParkingSlots": numberOfParkingSlots,
      "typeOfStores": typeOfStores,
    };
  }
}
