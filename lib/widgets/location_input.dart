import 'package:flutter/material.dart';
import 'package:great_places/utils/constants.dart';

import '../utils/dimensions.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

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
              : Image.network(_previewImageUrl!),
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
              onPressed: () {},
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
