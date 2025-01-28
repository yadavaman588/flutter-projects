import 'package:get/get.dart';

class DataController extends GetxController {
  var sharedMap = <String, dynamic>{}.obs;

  void addData(String key, dynamic value) {
    sharedMap[key] = value;
  }
}
