import 'package:destiny/views/search_card.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

// Scroll to the top with animation
    void scrollToTop() {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }

    final List<Map<String, String>> data = [
      {
        "time1": "11:10",
        "time2": "02:10",
        "city1": "Shahjahanpur",
        "city2": "Vishakapatnam",
        "price": "\$460",
        "owner": "Aman"
      },
      {
        "time1": "12:20",
        "time2": "03:15",
        "city1": "Delhi",
        "city2": "Mumbai",
        "price": "\$560",
        "owner": "Aman"
      },
      {
        "time1": "09:45",
        "time2": "12:30",
        "city1": "Bangalore",
        "city2": "Chennai",
        "price": "\$340",
        "owner": "Aman"
      },
      {
        "time1": "09:45",
        "time2": "12:30",
        "city1": "Bangalore",
        "city2": "Chennai",
        "price": "\$340",
        "owner": "Aman"
      },
      {
        "time1": "09:45",
        "time2": "12:30",
        "city1": "Bangalore",
        "city2": "Chennai",
        "price": "\$340",
        "owner": "Aman"
      },
      {
        "time1": "09:45",
        "time2": "12:30",
        "city1": "Bangalore",
        "city2": "Chennai",
        "price": "\$340",
        "owner": "Aman"
      },
      {
        "time1": "09:45",
        "time2": "12:30",
        "city1": "Bangalore",
        "city2": "Chennai",
        "price": "\$340",
        "owner": "Aman"
      },
    ];

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.chevron_left),
                  Text("Full text Here"),
                  Text("Filter")
                ],
              )
                  .box
                  .roundedSM
                  .border(color: Colors.grey)
                  .margin(const EdgeInsets.symmetric(horizontal: 16))
                  .padding(const EdgeInsets.all(14))
                  .make(),
              Padding(
                padding: const EdgeInsets.all(25),
                child: "Today".text.fontWeight(FontWeight.bold).size(22).make(),
              ),
              // Use Expanded to allow ListView.builder to take the remaining space
              Expanded(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
