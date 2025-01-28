import 'package:destiny/consts/const.dart';
import 'package:destiny/controllers/home_controller.dart';
import 'package:destiny/views/home_screen/home_screen.dart';
import 'package:destiny/views/inbox_screen.dart';
import 'package:destiny/views/myrides_screen.dart';
import 'package:destiny/views/profile_screen.dart';
import 'package:destiny/views/publish_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navBarItem = [
      const BottomNavigationBarItem(icon: Icon(Icons.search), label: home),
      const BottomNavigationBarItem(icon: Icon(Icons.add), label: publish),
      const BottomNavigationBarItem(
          icon: Icon(Icons.car_rental), label: myrides),
      const BottomNavigationBarItem(icon: Icon(Icons.chat), label: inbox),
      const BottomNavigationBarItem(
          icon: Icon(Icons.account_box), label: account)
    ];

    var navBody = [
      const HomeScreen(),
      const Publishscreen(),
      const MyRidesScreen(),
      const InboxScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
        body: PageView(
          controller:
              controller.pageController, // Use the controller's PageController
          onPageChanged: (index) {
            controller.currentNavIndex.value = index;
            FocusScope.of(context).unfocus();

            // Update the index when the page is swiped
          },
          physics: const BouncingScrollPhysics(),
          children: navBody,
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: Colors.green,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            items: navBarItem,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              controller.currentNavIndex.value = value;
              controller.pageController.jumpToPage(value);
            },
          ),
        ));
  }
}
