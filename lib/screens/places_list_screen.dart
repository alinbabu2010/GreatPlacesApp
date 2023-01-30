import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:great_places/utils/constants.dart';
import 'package:great_places/utils/dimensions.dart';
import 'package:great_places/widgets/places_list_item.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.yourPlaces),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Consumer<GreatPlaces>(
        builder: (context, places, child) => places.items.isEmpty
            ? child!
            : Padding(
                padding: const EdgeInsets.only(
                    left: Dimensions.placesListSidePadding,
                    right: Dimensions.placesListSidePadding,
                    bottom: Dimensions.placesListBottomPadding),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final place = places.items[index];
                    return PlacesListItem(place, () {
                      // TODO:Go to detail page..
                    });
                  },
                  itemCount: places.items.length,
                ),
              ),
        child: const Center(
          child: Text(
            Constants.gotNoPlaces,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Dimensions.placesListEmptyFontSize,
              fontWeight: FontWeight.w500,
              color: Colors.brown,
            ),
          ),
        ),
      ),
    );
  }
}
