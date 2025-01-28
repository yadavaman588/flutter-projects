import 'package:destiny/consts/const.dart';
import 'package:destiny/controllers/home_controller.dart';
import 'package:destiny/controllers/travellers_controller.dart';
import 'package:destiny/views/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class Travellers extends StatelessWidget {
  Travellers({super.key});

  final TravellersController controller = Get.put(TravellersController());

  @override
  Widget build(BuildContext context) {
    var controller2 = Get.put(HomeController());
    return Container(
      height: context.screenHeight,
      width: context.screenWidth,
      color: Colors.white,
      child: Obx(
        () => Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 40, 8, 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Number of seats to book"
                      .text
                      .size(26)
                      .fontWeight(FontWeight.bold)
                      .make(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 30, 12, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Decrease seats button
                  const Icon(
                    Icons.remove_circle_outline,
                    size: 40,
                  ).onTap(() {
                    if (controller.numberOfSeats > 1) {
                      controller.numberOfSeats.value--;
                    }
                  }),
                  // Display number of seats
                  Padding(
                    padding: const EdgeInsets.only(left: 110),
                    child: controller.numberOfSeats
                        .toString()
                        .text
                        .size(50)
                        .fontWeight(FontWeight.bold)
                        .make(),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  // Increase seats button
                  const Padding(
                    padding: EdgeInsets.only(left: 100),
                    child: Icon(
                      Icons.add,
                      size: 40,
                    ),
                  ).onTap(() {
                    if (controller.numberOfSeats < 4) {
                      controller.numberOfSeats.value++;
                    }
                  }),
                ],
              ),
            ),
            const Flexible(
              child: SizedBox(
                height: 140,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 45,
                    color: Colors.blue,
                  )
                ],
              ),
            ).onTap(() {
              //
              controller2.seatsBooked.value = controller.numberOfSeats.value;
              Get.back();
            })
          ],
        ),
      ),
    );
  }
}
