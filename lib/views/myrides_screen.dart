import 'package:destiny/views/home_screen/home.dart';
import 'package:destiny/views/search_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyRidesScreen extends StatelessWidget {
  final bool? isPublished;
  final RxMap? sharedMap;
  const MyRidesScreen({super.key, this.isPublished, this.sharedMap});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevent default back navigation
      onPopInvokedWithResult: (didPop, result) {
        Get.offAll(() => const Home());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Visibility(
            visible: isPublished == true,
            child: BackButton(
              onPressed: () {
                Get.offAll(() => const Home());
              },
            ),
          ),
        ),
        backgroundColor: Colors.white, // Sets the background color to white

        body: sharedMap == null
            ? const Center(
                child: Text(
                  'There are no rides available',
                  style: TextStyle(fontSize: 24),
                ),
              )
            : Column(
                children: [
                  Text("GOt IY")
                  /* Expanded(
                child: ListView.builder(
                  controller: ScrollController(),
                  addAutomaticKeepAlives: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(15),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: RepaintBoundary(
                        child: SearchCard(
                          time1: item["time1"]!,
                          time2: item["time2"]!,
                          city1: item["city1"]!,
                          city2: item["city2"]!,
                          price: item["price"]!,
                          owner: item["owner"]!,
                        ),
                      ),
                    );
                  },
                ),
              ),*/
                ],
              ),
      ),
    );
  }
}
