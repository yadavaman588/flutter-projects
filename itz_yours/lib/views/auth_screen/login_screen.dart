import 'package:get/get.dart';
import 'package:itz_yours/consts/consts.dart';
import 'package:itz_yours/consts/lists.dart';
import 'package:itz_yours/controllers/auth_controller.dart';
import 'package:itz_yours/views/auth_screen/signup_screen.dart';
import 'package:itz_yours/views/home_screen/home.dart';
import 'package:itz_yours/widgets_commo/app_logo.dart';
import 'package:itz_yours/widgets_commo/bg_widget.dart';
import 'package:itz_yours/widgets_commo/custom_textfield.dart';
import 'package:itz_yours/widgets_commo/our_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            20.heightBox,
            "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(
                      title: email,
                      hint: emailHint,
                      isPass: false,
                      controller: controller.emailController),
                  customTextField(
                      title: password,
                      hint: passswordHint,
                      isPass: true,
                      controller: controller.passwordController),
                  TextButton(onPressed: () {}, child: forgotPass.text.make()),
                  5.heightBox,
                  controller.isLoading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      : ourButton(
                              onPress: () async {
                                controller.isLoading(true);
                                await controller
                                    .loginMethod(context: context)
                                    .then((value) {
                                  if (value != null) {
                                    VxToast.show(context, msg: loggedin);
                                    Get.offAll(() => const Home());
                                  } else {
                                    controller.isLoading(false);
                                  }
                                });
                              },
                              color: redColor,
                              textColor: whiteColor,
                              title: login)
                          .box
                          .width(context.screenWidth - 50)
                          .make(),
                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  ourButton(
                          onPress: () {
                            Get.to(() => const SignupScreen());
                          },
                          color: lightGrey,
                          textColor: redColor,
                          title: signup)
                      .box
                      .width(context.screenWidth - 50)
                      .make(),
                  10.heightBox,
                  loginWith.text.color(fontGrey).size(10).make(),
                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: lightGrey,
                                radius: 20,
                                child: Image.asset(
                                  socialIconList[index],
                                  width: 30,
                                ),
                              ),
                            )),
                  )
                ],
              )
                  .box
                  .white
                  .rounded
                  .shadowSm
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .make(),
            )
          ],
        ),
      ),
    ));
  }
}
