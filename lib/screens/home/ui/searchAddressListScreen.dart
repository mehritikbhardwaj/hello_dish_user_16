import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello_dish_app/utilities/const.dart';
import 'package:hello_dish_app/utilities/sizedBox.dart';
import 'package:http/http.dart' as http;

class SearchAreaScreen extends StatefulWidget {
  const SearchAreaScreen({super.key});

  @override
  AreaSearchScreenState createState() => AreaSearchScreenState();
}

class AreaSearchScreenState extends State<SearchAreaScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _suggestions = [];
  final Map<String, String> _suggestionDetails = {};

  Future<void> _fetchSuggestions(String query) async {
    const apiKey = 'AIzaSyA0mRlUvgR2LbYdrkqaGmJjaSO5LSgz7d8';
    final url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final predictions = data['predictions'] as List<dynamic>;
      setState(() {
        _suggestions = predictions
            .map((prediction) => prediction['description'] as String)
            .toList();
      });
    } else {
      throw Exception('Failed to load suggestions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.chevron_left_outlined,
                size: 28,
              ),
            ),
            boxB2(),
            Text(
              'Search your area',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
            child: Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(15.0),
              child: TextFormField(
                controller: _searchController,
                onChanged: (query) {
                  if (query.isNotEmpty) {
                    _fetchSuggestions(query);
                  } else {
                    setState(() {
                      _suggestions.clear();
                    });
                  }
                },
                style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: 'Enter area...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          // Container(
          //   margin: const EdgeInsets.symmetric(vertical: 8.0),
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       begin: Alignment.centerLeft,
          //       end: Alignment.centerRight,
          //       colors: [
          //         Colors.grey.withOpacity(0.1),
          //         Colors.grey.withOpacity(0.5),
          //         Colors.grey.withOpacity(0.1),
          //       ],
          //       stops: const [0, 0.5, 1],
          //     ),
          //   ),
          //   height: 1,
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                final suggestion = _suggestions[index];
                final details = _suggestionDetails[suggestion] ?? '';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 20.0),
                      child: Text(
                        suggestion,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    customDevider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        details,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
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
