import 'package:get/get.dart';
import 'package:itz_yours/consts/consts.dart';
import 'package:itz_yours/controllers/cart_controller.dart';
import 'package:itz_yours/views/cart_screen/payment_screen.dart';
import 'package:itz_yours/widgets_commo/custom_textfield.dart';
import 'package:itz_yours/widgets_commo/our_button.dart';

class PlaceorderScreen extends StatelessWidget {
  const PlaceorderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: whiteColor,
        appBar: AppBar(
            title: "Shipping Info"
                .text
                .fontFamily(semibold)
                .color(darkFontGrey)
                .make()),
// AppBar
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(18),
          child: ourButton(
            onPress: () {
              if (controller.addressController.text.length > 5 &&
                  controller.cityController.text.length > 2 &&
                  controller.stateController.text.length > 3 &&
                  controller.postalcodeController.text.length > 3 &&
                  controller.phoneController.text.length > 9) {
                Get.to(PaymentScreen());
              } else {
                VxToast.show(context,
                    msg: "Please Enter all details correctly");
              }
            },
            color: redColor,
            textColor: whiteColor,
            title: "Continue",
          ),
        ),

        // SizedBox
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              customTextField(
                  hint: "Address",
                  isPass: false,
                  title: "Address",
                  controller: controller.addressController),
              customTextField(
                  hint: "City",
                  isPass: false,
                  title: "City",
                  controller: controller.cityController),
              customTextField(
                  hint: "State",
                  isPass: false,
                  title: "State",
                  controller: controller.stateController),
              customTextField(
                  hint: "Postal Code",
                  isPass: false,
                  title: "Postal Code",
                  controller: controller.postalcodeController),
              customTextField(
                  hint: "Phone",
                  isPass: false,
                  title: "Phone",
                  controller: controller.phoneController),
            ],
          ), // Column
        ));
  }
}
