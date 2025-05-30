import 'package:get/get.dart';
import 'package:itz_yours/consts/consts.dart';
import 'package:itz_yours/controllers/home_controller.dart';
import 'package:itz_yours/views/auth_screen/login_screen.dart';
import 'package:itz_yours/views/cart_screen/cart_screen.dart';
import 'package:itz_yours/views/category_screen/category_screen.dart';
import 'package:itz_yours/views/home_screen/home_screen.dart';
import 'package:itz_yours/views/profile_screen/profile_screen.dart';
import 'package:itz_yours/widgets_commo/exit_dialog.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navBarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(icHome, width: 26), label: home),
      BottomNavigationBarItem(
          icon: Image.asset(icCategories, width: 26), label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(icCart, width: 26), label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(icProfile, width: 26), label: account)
    ];

    var navBody = [
      const HomeScreen(),
      const CateoryScreen(),
      const CartScreen(),
      const ProfileScreen()
    ];

    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: PageView(
          controller:
              controller.pageController, // Use the controller's PageController
          onPageChanged: (index) {
            controller.currentNavIndex.value =
                index; // Update the index when the page is swiped
          },
          children: navBody,
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: redColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            items: navBarItem,
            backgroundColor: whiteColor,
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              controller.currentNavIndex.value = value;
              controller.pageController.jumpToPage(value);
            },
          ),
        ),
      ),
    );
  }
}
