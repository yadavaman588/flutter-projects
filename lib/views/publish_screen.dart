import 'package:destiny/components/location_service.dart';
import 'package:destiny/controllers/data_controller.dart';
import 'package:destiny/views/publish_final.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:velocity_x/velocity_x.dart';

class Publishscreen extends StatefulWidget {
  const Publishscreen({super.key});

  @override
  State<Publishscreen> createState() => _PublishscreenState();
}

class _PublishscreenState extends State<Publishscreen> {
  var dataController = Get.put(DataController());

  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode(); // FocusNode for the SearchBar
  bool isLoading = false;
  bool isLocationSelected = false; // Track if a location is selected
  final LocationService _locationService = LocationService();
  final String sessionToken = const Uuid().v4(); // Unique session token
  List<dynamic> listOfLocation = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onChange);
    searchFocusNode.addListener(_onFocusChange); // Listen for focus changes
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose(); // Dispose the FocusNode
    super.dispose();
  }

  void _onChange() {
    _fetchSuggestions(searchController.text);
  }

  void _onFocusChange() {
    if (searchFocusNode.hasFocus) {
      setState(() {
        isLocationSelected = false; // Reset when SearchBar gains focus
      });
    }
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

  void _onLocationSelected(String location) {
    setState(() {
      searchController.text = location; // Update search bar text
      isLocationSelected = true; // Mark location as selected
      listOfLocation = []; // Clear suggestions
      searchFocusNode.unfocus(); // Remove focus from SearchBar
    });
  }

  Widget searchBar(String hint) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(13, 16, 13, 2),
        child: SearchBar(
          textInputAction: TextInputAction.done,
          controller: searchController,
          focusNode: searchFocusNode, // Assign FocusNode
          leading: const BackButton(),

          backgroundColor: const WidgetStatePropertyAll(Colors.white),
          hintText: hint,
          hintStyle:
              const WidgetStatePropertyAll(TextStyle(color: Colors.grey)),
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
                    isLocationSelected = false; // Reset on clear
                  });
                },
              ),
          ],
          onChanged: (value) {
            setState(() {});
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white, // Sets the background color to white
        body: Container(
            width: context.screenWidth,
            color: Colors.white,
            child: Column(children: [
              const SizedBox(height: 30),
              searchBar("Where are you Going?"),
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
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            onTap: () {
                              _onLocationSelected(
                                  listOfLocation[index]["description"]);
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
              Visibility(
                visible: isLocationSelected,
                // Only show check circle if location is selected
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 45,
                        color: Colors.blue,
                      )
                    ],
                  ),
                ).onTap(() {
                  dataController.addData('destination', searchController.text);
                  Get.to(PublishFinal());
                }),
              ),
            ])));
  }
}
