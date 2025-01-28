import 'package:destiny/controllers/publishride_controller.dart';
import 'package:destiny/views/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class PublishRide extends StatefulWidget {
  const PublishRide({super.key});

  @override
  State<PublishRide> createState() => _PublishRideState();
}

class _PublishRideState extends State<PublishRide> {
  final publishrideController = Get.put(PublishrideController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: context.screenWidth,
        child: Obx(
          () => Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 40, 8, 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Number of seats available"
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
                      if (publishrideController.numberOfSeats > 1) {
                        publishrideController.numberOfSeats.value--;
                      }
                    }),
                    // Display number of seats
                    Padding(
                      padding: const EdgeInsets.only(left: 110),
                      child: publishrideController.numberOfSeats
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
                      if (publishrideController.numberOfSeats < 4) {
                        publishrideController.numberOfSeats.value++;
                      }
                    }),
                  ],
                ),
              ),
              const SizedBox(
                height: 125,
              ),
              ElevatedButton(
                onPressed: () {},
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blue),
                ),
                child: const Text(
                  "Publish Ride",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
