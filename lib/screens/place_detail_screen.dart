import 'package:flutter/material.dart';
import 'package:great_places/data/models/place.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/maps_screen.dart';
import 'package:great_places/utils/constants.dart';
import 'package:great_places/utils/dimensions.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = "/place_detail";

  const PlaceDetailScreen({Key? key}) : super(key: key);

  void openMapScreen(BuildContext context, Place selectedPlace) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MapsScreen(placeLocation: selectedPlace.location),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments.toString();
    final selectedPlace = Provider.of<GreatPlaces>(
      context,
      listen: false,
    ).findById(id!);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: Dimensions.placeDetailBoxHeight),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: Dimensions.placeDetailAddressFontSize,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: Dimensions.placeDetailBoxHeight),
          TextButton(
            onPressed: () => openMapScreen(context, selectedPlace),
            style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(
                  Theme.of(context).colorScheme.primary),
            ),
            child: const Text(Constants.viewOnMap),
          )
        ],
      ),
    );
  }
}
