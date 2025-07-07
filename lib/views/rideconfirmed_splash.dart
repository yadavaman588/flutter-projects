// ignore_for_file: file_names

import 'package:destiny/controllers/data_controller.dart';
import 'package:destiny/views/myrides_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class RideconfirmedSplash extends StatefulWidget {
  const RideconfirmedSplash({super.key});

  @override
  State<RideconfirmedSplash> createState() => _RideconfirmedSplashState();
}

class _RideconfirmedSplashState extends State<RideconfirmedSplash> {
  var dataController = Get.put(DataController());
  changescreen() {
    Future.delayed(const Duration(milliseconds: 900), () {
      //
      Get.offAll(() => MyRidesScreen(
            isPublished: true,
            sharedMap: dataController.sharedMap,
          ));
    });
  }

  @override
  void initState() {
    changescreen();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.screenWidth,
        color: Colors.green,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 65,
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Your Ride has been Published",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
