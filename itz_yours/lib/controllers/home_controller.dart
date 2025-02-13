import 'package:get/get.dart';
import 'package:itz_yours/consts/consts.dart';

class HomeController extends GetxController {
  late PageController pageController;
  var searchController = TextEditingController();
  @override
  void onInit() {
    getUsername();
    pageController = PageController(
        initialPage: currentNavIndex.value); // TODO: implement onInit
    super.onInit();
  }

  void onClose() {
    pageController
        .dispose(); // Dispose the PageController when the controller is closed
    super.onClose();
  }

  var currentNavIndex = 0.obs;
  var username = '';

  getUsername() async {
    var n = await firestore
        .collection(usersCollection)
        .where('id', isEqualTo: currentuser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });

    username = n;
  }
}
