import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/data/models/place_location.dart';

import '../utils/constants.dart';

class MapsScreen extends StatefulWidget {
  final PlaceLocation placeLocation;

  final bool isSelecting;

  const MapsScreen({
    super.key,
    required this.placeLocation,
    this.isSelecting = false,
  });

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  LatLng? _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.yourMap),
        actions: [
          if (widget.isSelecting)
            IconButton(
                onPressed: _pickedLocation == null
                    ? null
                    : () => Navigator.of(context).pop(_pickedLocation),
                icon: const Icon(Icons.check))
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.placeLocation.latitude,
            widget.placeLocation.longitude,
          ),
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: _pickedLocation == null
            ? {}
            : {
                Marker(
                    markerId: const MarkerId('m1'), position: _pickedLocation!)
              },
      ),
    );
  }
}
