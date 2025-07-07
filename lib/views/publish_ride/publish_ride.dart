import 'package:destiny/controllers/data_controller.dart';
import 'package:destiny/controllers/publishride_controller.dart';
import 'package:destiny/views/home_screen/home_screen.dart';
import 'package:destiny/views/publish_ride/components/price_input_formatter.dart';
import 'package:destiny/views/rideConfirmed_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class PublishRide extends StatefulWidget {
  const PublishRide({super.key});

  @override
  State<PublishRide> createState() => _PublishRideState();
}

class _PublishRideState extends State<PublishRide> {
  final NumberFormat _formatter = NumberFormat("#,##0.##", "en_US");
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;

    // Remove commas to parse correctly
    String cleanedText = newValue.text.replaceAll(',', '');

    double? parsedValue = double.tryParse(cleanedText);
    if (parsedValue == null) return oldValue; // Keep old value if invalid

    // Format with commas (e.g., 1000 → 1,000)
    String newText = _formatter.format(parsedValue);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  final publishrideController = Get.put(PublishrideController());
  var dataController = Get.put(DataController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Price Per Person"
                      .text
                      .size(26)
                      .fontWeight(FontWeight.bold)
                      .make(),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: publishrideController.price,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                textAlignVertical:
                    TextAlignVertical.center, // Align text vertically
                textAlign:
                    TextAlign.left, // Align text horizontally (left by default)
                style:
                    const TextStyle(fontSize: 20), // Match text size with icon
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(
                      r'^\d*\.?\d{0,2}$')), // Allows only numbers and up to 2 decimal places
                  PriceInputFormatter(), // Auto-format numbers with commas
                ],

                decoration: const InputDecoration(
                  prefixIcon:
                      Icon(Icons.currency_rupee, size: 22), // Adjust icon size
                  isDense: true, // Reduce extra padding
                  hintStyle: TextStyle(
                      fontSize: 18, color: Colors.grey), // Match hint text size
                  hintText: "Price",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 12, horizontal: 10), // Proper padding
                ),
              ).box.size(context.screenWidth / 3, 50).make(),
              const SizedBox(
                height: 125,
              ),
              ElevatedButton(
                onPressed: () {
                  dataController.addData('seats_available',
                      publishrideController.numberOfSeats.value);
                  if (publishrideController.price.text.isNotEmpty) {
                    dataController.addData(
                        'price', publishrideController.price.text);
                    print(dataController.sharedMap['price']);
                  }
                  print(dataController.sharedMap['pickup']);
                  print(dataController.sharedMap['depart_time']);
                  print(dataController.sharedMap['depart_date']);
                  print(dataController.sharedMap['seats_available']);

                  if (publishrideController.price.text.isNotEmpty) {
                    Get.to(RideconfirmedSplash());
                  } else {
                    VxToast.show(context, msg: "Please enter price");
                  }
                },
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
