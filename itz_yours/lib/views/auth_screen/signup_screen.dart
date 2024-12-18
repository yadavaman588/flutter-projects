import 'package:get/get.dart';
import 'package:itz_yours/consts/consts.dart';
import 'package:itz_yours/controllers/auth_controller.dart';
import 'package:itz_yours/views/home_screen/home.dart';
import 'package:itz_yours/widgets_commo/app_logo.dart';
import 'package:itz_yours/widgets_commo/bg_widget.dart';
import 'package:itz_yours/widgets_commo/custom_textfield.dart';
import 'package:itz_yours/widgets_commo/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            20.heightBox,
            "Signup for $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(
                      title: name,
                      hint: nameHint,
                      controller: nameController,
                      isPass: false),
                  customTextField(
                      title: email,
                      hint: emailHint,
                      controller: emailController,
                      isPass: false),
                  customTextField(
                      title: password,
                      hint: passswordHint,
                      controller: passwordController,
                      isPass: true),
                  customTextField(
                      title: retypePassword,
                      hint: passswordHint,
                      controller: passwordRetypeController,
                      isPass: true),
                  TextButton(onPressed: () {}, child: forgotPass.text.make()),
                  5.heightBox,
                  Row(
                    children: [
                      Checkbox(
                          checkColor: redColor,
                          value: isCheck,
                          onChanged: (newValue) {
                            setState(() {
                              isCheck = newValue;
                            });
                          }),
                      Expanded(
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                              text: "I agree to the",
                              style: TextStyle(
                                fontFamily: bold,
                                fontSize: 12,
                                color: fontGrey,
                              )),
                          TextSpan(
                              text: " terms and conditions",
                              style: TextStyle(
                                fontFamily: bold,
                                fontSize: 12,
                                color: redColor,
                              )),
                          TextSpan(
                              text: " & ",
                              style: TextStyle(
                                fontFamily: bold,
                                fontSize: 12,
                                color: fontGrey,
                              )),
                          TextSpan(
                              text: privacyPolicy,
                              style: TextStyle(
                                fontFamily: bold,
                                fontSize: 12,
                                color: redColor,
                              ))
                        ])),
                      )
                    ],
                  ),
                  controller.isLoading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      : ourButton(
                              onPress: () async {
                                if (isCheck != false) {
                                  controller.isLoading(true);
                                  try {
                                    await controller
                                        .signupMethod(
                                            context: context,
                                            email: emailController.text,
                                            password: passwordController.text)
                                        .then((value) {
                                      return controller.storeUserData(
                                        email: emailController.text,
                                        name: nameController.text,
                                        password: passwordController.text,
                                      );
                                    }).then((value) {
                                      // ignore: use_build_context_synchronously
                                      VxToast.show(context, msg: loggedin);
                                      Get.offAll(() => const Home());
                                    });
                                  } catch (e) {
                                    auth.signOut();
                                    // ignore: use_build_context_synchronously
                                    VxToast.show(context, msg: e.toString());

                                    controller.isLoading(false);
                                  }
                                }
                              },
                              color: isCheck == true ? redColor : lightGrey,
                              textColor: whiteColor,
                              title: signup)
                          .box
                          .width(context.screenWidth - 50)
                          .make(),
                  10.heightBox,
                  RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                      text: alreadyHaveAcc,
                      style: TextStyle(fontFamily: bold, color: fontGrey),
                    ),
                    TextSpan(
                      text: login,
                      style: TextStyle(fontFamily: bold, color: redColor),
                    )
                  ])).onTap(() {
                    Get.back();
                  })
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
