import 'dart:async';

import 'package:destiny/consts/images.dart';
import 'package:destiny/controllers/home_controller.dart';
import 'package:destiny/controllers/travellers_controller.dart';
import 'package:destiny/main.dart';
import 'package:destiny/views/home_screen/destination_location.dart';
import 'package:destiny/views/home_screen/recent_rides.dart';
import 'package:destiny/views/home_screen/ride_details.dart';
import 'package:destiny/views/home_screen/source_location.dart';
import 'package:destiny/views/home_screen/travellers.dart';
import 'package:destiny/views/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  final String? location;
  const HomeScreen({super.key, this.location});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());
  String destination = '';
  String sourceLocation = '';

  DateTime? pickedDate;

  String _getFormattedDate(DateTime date) {
    DateTime today = DateTime.now();
    DateTime tomorrow = today.add(const Duration(days: 1));

    if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day) {
      return 'Today';
    } else if (date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day) {
      return 'Tomorrow';
    } else {
      return DateFormat('EEE, MMM d').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime? today = DateTime.now();
    DateTime? lastDate = today.add(const Duration(days: 35));
    var screenHeight = context.screenHeight;
    var ispotrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),

        // Makes the entire screen scrollable
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              // Top Banner
              Container(
                  height: 600,
                  width: context.screenWidth,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(imgBackground), fit: BoxFit.fill)),
                  child: Container(
                    margin: const EdgeInsets.only(top: 65),
                    padding: const EdgeInsets.fromLTRB(40, 170, 40, 30),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                var selectedLocation =
                                    await showModalBottomSheet<String>(
                                  useSafeArea: true,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (ctx) {
                                    return const SourceLocation();
                                  },
                                );

                                // Update the UI with the selected location if it exists
                                if (selectedLocation != null &&
                                    selectedLocation.isNotEmpty) {
                                  setState(() {
                                    sourceLocation =
                                        selectedLocation; // Save the selected location
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 12.0),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey,
                                        width: 1.0), // Mimic underline border
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.circle_outlined,
                                        color: Colors.black),
                                    const SizedBox(width: 12),
                                    Expanded(
                                        child: Text(
                                      sourceLocation.isNotEmpty
                                          ? sourceLocation
                                          : 'Leaving from', // Display selected location
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow
                                          .ellipsis, // Truncate text if it  overflows
                                      maxLines: 1, // Display a single line
                                    )),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            GestureDetector(
                              onTap: () async {
                                // Open the modal bottom sheet and wait for the selected location
                                var selectedLocation =
                                    await showModalBottomSheet<String>(
                                  useSafeArea: true,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (ctx) {
                                    return const DestinationLocation();
                                  },
                                );

                                // Update the UI with the selected location if it exists
                                if (selectedLocation != null &&
                                    selectedLocation.isNotEmpty) {
                                  setState(() {
                                    destination =
                                        selectedLocation; // Save the selected location
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 12.0),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 1.0, // Mimic underline border
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.circle_outlined,
                                        color: Colors.black),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        destination.isNotEmpty
                                            ? destination
                                            : 'Going To', // Display selected location
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow
                                            .ellipsis, // Truncate text if it overflows
                                        maxLines: 1, // Display a single line
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            GestureDetector(
                              onTap: () async {
                                DateTime? selectedDate = await showDatePicker(
                                  initialEntryMode:
                                      DatePickerEntryMode.calendarOnly,
                                  context: context,
                                  initialDate: pickedDate ?? DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: lastDate,
                                );

                                if (selectedDate != null) {
                                  setState(() {
                                    pickedDate = selectedDate;
                                  });
                                }
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.calendar_today,
                                        color: Colors.grey),
                                    const SizedBox(width: 11),
                                    Expanded(
                                      child: Text(
                                        pickedDate == null
                                            ? 'Today' // If null, display "Today"
                                            : _getFormattedDate(
                                                pickedDate!), // Format the date
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (ctx) {
                                    if (screenHeight < 477.3333333333333) {
                                      return SingleChildScrollView(
                                          physics:
                                              const ClampingScrollPhysics(),
                                          child: Travellers());
                                    } else if (ispotrait == false) {
                                      return SingleChildScrollView(
                                          physics:
                                              const ClampingScrollPhysics(),
                                          child: Travellers());
                                    } else {
                                      return Travellers();
                                    }
                                  },
                                ).whenComplete(() {
                                  Get.delete<TravellersController>();
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 3),
                                child: Obx(
                                  () => Row(
                                    children: [
                                      const Icon(Icons.person,
                                          color: Colors.grey),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                        child: Text(homeController
                                            .seatsBooked.value
                                            .toString()),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double
                                  .infinity, // Makes the button stretch horizontally
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.to(SearchScreen());
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0), // Adjust height
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        8.0), // Optional: Rounded corners
                                  ),
                                ),
                                child: const Text(
                                  'Search',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),

              // Search Card positioned over the banner

              // Scrollable Ride Details List (no Expanded now)

              ListView.builder(
                padding: const EdgeInsets.all(2),
                physics:
                    const NeverScrollableScrollPhysics(), // Prevents independent scrolling
                shrinkWrap:
                    true, // Ensures the ListView takes only as much height as needed
                itemCount: rideDetails.length,
                itemBuilder: (context, index) {
                  final ride = rideDetails[index];
                  return RideDetailCard(
                    from: ride['from']!,
                    to: ride['to']!,
                    date: ride['date']!,
                    passengers: ride['passengers']!,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
