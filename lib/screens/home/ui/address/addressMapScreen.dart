import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
// Only to control hybrid composition and the renderer in Android
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  final LatLng location1 = LatLng(37.657, -122.776);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: PlacePicker(
          apiKey: "AIzaSyA0mRlUvgR2LbYdrkqaGmJjaSO5LSgz7d8",
          initialPosition: location1,
          useCurrentLocation: true,
          selectInitialPosition: true,
          usePlaceDetailSearch: true,
          searchForInitialValue: true,
          onPlacePicked: (result) {
            print(result.addressComponents);
            Navigator.of(context).pop();
          },
          selectedPlaceWidgetBuilder:
              (_, selectedPlace, state, isSearchBarFocused) {
            if (Platform.isIOS) {
              if (selectedPlace != null) {
                state = SearchingState.Idle;
              }
            }

            return Padding(
              padding: const EdgeInsets.only(top: 80.0, left: 15),
              child: Text(selectedPlace!.formattedAddress.toString(),
                  style: TextStyle(fontSize: 25)),
            );
          }),
    ));
  }
}
