import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchCard extends StatelessWidget {
  final String? time1;
  final String? time2;
  final String? city1;
  final String? city2;
  final String? price;
  final String? owner;

  const SearchCard(
      {super.key,
      this.time1,
      this.time2,
      this.city1,
      this.city2,
      this.price,
      this.owner});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Prevent vertical expansion
          children: [
            Row(
              mainAxisSize: MainAxisSize.min, // Prevent vertical expansion
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // First timeline
                SizedBox(
                  width: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "$time1".text.make(),
                      const SizedBox(height: 30), // Matches space for alignment
                      "$time2".text.make(),
                    ],
                  ),
                ),
                const SizedBox(width: 8), // Small gap
                // Vertical line with dots
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.circle, size: 10, color: Colors.blue),
                    Container(
                      width: 2,
                      height: 40, // Adjust line height to match text alignment
                      color: Colors.grey,
                    ),
                    const Icon(Icons.circle, size: 10, color: Colors.blue),
                  ],
                ),
                const SizedBox(width: 16), // Space between line and cities
                // City names (aligned with icons)
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: "$city1"
                            .text
                            .size(16)
                            .overflow(TextOverflow.ellipsis)
                            .maxLines(1)
                            .fontWeight(FontWeight.bold)
                            .make(),
                      ),
                      const SizedBox(height: 25), // Matches space for alignment
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: "$city2"
                            .text
                            .size(16)
                            .overflow(TextOverflow.ellipsis)
                            .fontWeight(FontWeight.bold)
                            .maxLines(1)
                            .make(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16), // Space between cities and price
                // Spacer ensures price moves to the far right
                const Spacer(),
                // Price at the extreme right
                "$price".text.size(22).make(),
              ],
            ),
            const SizedBox(height: 14),
            const Divider(color: Colors.grey),
            Row(children: [
              CircleAvatar(
                radius: 16, // Size of the profile icon
                backgroundImage: const NetworkImage(
                    'https://via.placeholder.com/150'), // Replace with your image URL
                backgroundColor:
                    Colors.grey[300], // Background color if no image
                child: const Icon(
                  Icons.person,
                  size: 16,
                  color:
                      Colors.white, // Fallback icon if the image doesn't load
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              "$owner".text.make()
            ]),
          ],
        ),
      ),
    );
  }
}
