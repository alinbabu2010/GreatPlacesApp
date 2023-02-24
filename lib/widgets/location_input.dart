import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/managers/location_manager.dart';
import 'package:great_places/screens/maps_screen.dart';
import 'package:great_places/utils/constants.dart';

import '../data/models/place_location.dart';
import '../utils/dimensions.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  const LocationInput(this.onSelectPlace, {Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview(double latitude, double longitude) {
    setState(() {
      _previewImageUrl =
          LocationManger.generatedLocationPreviewUrl(latitude, longitude);
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final placeLocation = await LocationManger.getCurrentUserLocation();
      _showPreview(placeLocation.latitude, placeLocation.longitude);
      widget.onSelectPlace(placeLocation.latitude, placeLocation.longitude);
    } catch (_) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLocation =
        await Navigator.of(context).push<LatLng>(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => MapsScreen(
        placeLocation: PlaceLocation(
          latitude: 8.8151,
          longitude: 76.7613,
        ),
        isSelecting: true,
      ),
    ));
    if (selectedLocation == null) return;
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
                  width: Dimensions.locInputContainerBorderWidth,
                  color: Colors.grey)),
          child: _previewImageUrl == null
              ? const Text(
                  Constants.noLocation,
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.fill,
                  errorBuilder: (__, exception, error) {
                    return Text(
                      kDebugMode ? exception.toString() : Constants.noLocation,
                      textAlign: TextAlign.center,
                    );
                  },
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text(Constants.currentLocation),
              style: TextButton.styleFrom(
                backgroundColor: Colors.black12,
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                _getCurrentUserLocation();
              },
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text(Constants.selectOnMap),
              style: TextButton.styleFrom(
                backgroundColor: Colors.black12,
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
              onPressed: _selectOnMap,
            ),
          ],
        )
      ],
    );
  }
}
