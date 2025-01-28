import 'package:destiny/components/location_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class DestinationLocation extends StatefulWidget {
  const DestinationLocation({super.key});

  @override
  State<DestinationLocation> createState() => _DestinationLocationState();
}

class _DestinationLocationState extends State<DestinationLocation> {
  final searchController = TextEditingController();
  final LocationService _locationService = LocationService();
  final String sessionToken = const Uuid().v4(); // Unique session token
  List<dynamic> listOfLocation = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onChange);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _onChange() {
    _fetchSuggestions(searchController.text);
  }

  Future<void> _fetchSuggestions(String input) async {
    if (input.isNotEmpty) {
      List<dynamic> suggestions =
          await _locationService.fetchPlaceSuggestions(input, sessionToken);
      setState(() {
        listOfLocation = suggestions;
      });
    } else {
      setState(() {
        listOfLocation = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SearchBar(
              textInputAction: TextInputAction.done,
              enabled: true,
              autoFocus: true,
              leading: const BackButton(),
              backgroundColor: const WidgetStatePropertyAll(Colors.white),
              controller: searchController,
              trailing: [
                if (searchController.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        searchController.clear();
                      });
                    },
                  ),
              ],
              onSubmitted: (value) {
                var destinationLocation = searchController.text;
                Navigator.pop(context, destinationLocation);
              },
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Visibility(
            visible: searchController.text.isNotEmpty,
            child: Expanded(
              child: ListView.builder(
                itemCount: listOfLocation.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(listOfLocation[index]["description"],
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        onTap: () {
                          // Handle the tap event
                          setState(() {
                            searchController.text =
                                listOfLocation[index]["description"];
                          });
                        },
                      ),
                      if (index != listOfLocation.length - 1)
                        const Divider(), // Add a divider between items except the last one
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
