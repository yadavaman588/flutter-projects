import 'package:destiny/components/location_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:velocity_x/velocity_x.dart';

class SourceLocation extends StatefulWidget {
  const SourceLocation({super.key});

  @override
  State<SourceLocation> createState() => _SourceLocationState();
}

class _SourceLocationState extends State<SourceLocation> {
  final TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  final LocationService _locationService = LocationService();
  final String sessionToken = const Uuid().v4(); // Unique session token
  List<dynamic> listOfLocation = [];

  String address = "Fetching address...";

  Future<void> fetchAddress() async {
    setState(() {
      isLoading = true;
    });

    String result = await _locationService.getAddressFromLatLng();

    setState(() {
      address = result;
      isLoading = false;
    });
  }

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
      width: context.screenWidth,
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
                if (isLoading)
                  const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                else if (searchController.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        searchController.clear();
                      });
                    },
                  ),
              ],
              onChanged: (value) {
                setState(() {});
              },
              onSubmitted: (value) {
                var sourceLocation = searchController.text;
                Navigator.pop(context, sourceLocation);
              },
            ),
          ),
          searchController.text.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.location_on),
                      Text(
                        "Use your current location",
                        style: TextStyle(fontSize: 20),
                      ),
                      Icon(Icons.chevron_right, size: 30),
                    ],
                  ).onTap(() async {
                    await fetchAddress();
                    searchController.text = address;
                  }),
                )
              : Expanded(
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
        ],
      ),
    );
  }
}
