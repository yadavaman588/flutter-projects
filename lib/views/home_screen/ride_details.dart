import 'package:flutter/material.dart';

class RideDetailCard extends StatelessWidget {
  final String from;
  final String to;
  final String date;
  final String passengers;

  const RideDetailCard({
    super.key,
    required this.from,
    required this.to,
    required this.date,
    required this.passengers,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(19.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.schedule, color: Colors.grey),
                const SizedBox(width: 8),
                Text(from,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Text(' → $to', style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 8),
            Text('$date, $passengers',
                style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
