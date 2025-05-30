import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:itz_yours/consts/consts.dart';
import 'package:itz_yours/views/auth_screen/login_screen.dart';
import 'package:itz_yours/views/home_screen/home.dart';
import 'package:itz_yours/widgets_commo/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      //Get.to(() => const LoginScreen());
      StreamSubscription<User?>? _authStateSubscription;

      _authStateSubscription = auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          _authStateSubscription!.pause();
          Get.offAll(() => const LoginScreen());
        } else {
          _authStateSubscription!.pause();
          Get.offAll(() => const Home());
        }
      });
    });
  }

  @override
  void initState() {
    changeScreen();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  icSplashBg,
                  width: 300,
                )),
            20.heightBox,
            applogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).white.make(),
            5.heightBox,
            appversion.text.white.make(),
          ],
        ),
      ),
    );
  }
}
