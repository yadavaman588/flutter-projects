import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentNavIndex = 0.obs;
  var seatsBooked = 1.obs;
  late PageController pageController;
  @override
  void onInit() {
    pageController = PageController(initialPage: currentNavIndex.value);
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    // TODO: implement onClose
    super.onClose();
  }
}
