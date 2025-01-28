import 'package:get/get.dart';
import 'package:itz_yours/consts/consts.dart';
import 'package:itz_yours/consts/lists.dart';
import 'package:itz_yours/controllers/cart_controller.dart';
import 'package:itz_yours/widgets_commo/our_button.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
            onPress: () {
              controller.placeMyOrder(
                  orderPaymentMethod:
                      paymentMethods[controller.paymentIndex.value],
                  totalAmount: controller.totalP.value);
            },
            color: redColor,
            textColor: whiteColor,
            title: "Place my order"),
      ),
      appBar: AppBar(
        title: "Choose Payment method"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Obx(
          () => Column(
              children: List.generate(paymentMethodsListImg.length, (index) {
            return GestureDetector(
              onTap: () {
                controller.changePaymentIndex(index);
              },
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: controller.paymentIndex.value == index
                          ? Colors.green
                          : Colors.transparent,
                      width: 4,
                    )),
                margin: const EdgeInsets.only(bottom: 8),
                child: Stack(alignment: Alignment.topRight, children: [
                  Image.asset(
                    paymentMethodsListImg[index],
                    width: double.infinity,
                    colorBlendMode: controller.paymentIndex.value == index
                        ? BlendMode.darken
                        : BlendMode.color,
                    color: controller.paymentIndex.value == index
                        ? Colors.black.withOpacity(0.3)
                        : Colors.transparent,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                  Visibility(
                    visible: controller.paymentIndex.value == index,
                    child: Transform.scale(
                      scale: 1.3,
                      child: Checkbox(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          activeColor: Colors.green,
                          value: true,
                          onChanged: (value) {}),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 10,
                      child: paymentMethods[index]
                          .text
                          .color(whiteColor)
                          .fontFamily(bold)
                          .size(16)
                          .make())
                ]),
              ),
            );
          })),
        ),
      ),
    );
  }
}
