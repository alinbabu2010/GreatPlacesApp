import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:great_places/managers/location_manager.dart';
import 'package:great_places/utils/constants.dart';

import '../utils/dimensions.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final placeLocation = await LocationManger.getCurrentUserLocation();
    setState(() {
      _previewImageUrl = LocationManger.generatedLocationPreviewUrl(
        placeLocation.latitude,
        placeLocation.longitude,
      );
    });
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
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(Colors.black12),
                foregroundColor: MaterialStatePropertyAll(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
              onPressed: () {
                _getCurrentUserLocation();
              },
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text(Constants.selectOnMap),
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(Colors.black12),
                foregroundColor: MaterialStatePropertyAll(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }
}
