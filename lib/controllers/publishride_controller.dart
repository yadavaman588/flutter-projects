import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PublishrideController extends GetxController {
  var numberOfSeats = 1.obs;
  var price = TextEditingController();

  // Reactive variable
  @override
  void onClose() {
    super.onClose();
    numberOfSeats.value = 1; // Reset to initial value
  }
}
