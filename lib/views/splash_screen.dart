import 'package:destiny/consts/const.dart';
import 'package:destiny/views/home_screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changescreen() {
    Future.delayed(const Duration(seconds: 3), () {
      //
      Get.offAll(() => const Home());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    changescreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF95A5A6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                icApp,
                width: 110,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              appname,
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),

            /* 10.heightBox,
            appname.text.fontFamily(bold).size(22).white.make(),
            5.heightBox,
            appversion.text.white.make(),*/
          ],
        ),
      ),
    );
  }
}
