import 'package:get/get.dart';

class TravellersController extends GetxController {
  var numberOfSeats = 1.obs;

  // Reactive variable
  @override
  void onClose() {
    super.onClose();
    numberOfSeats.value = 1; // Reset to initial value
  }
}
