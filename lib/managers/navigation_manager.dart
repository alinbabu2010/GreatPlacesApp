import 'package:flutter/material.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:great_places/screens/place_detail_screen.dart';

class NavigationManager {
  NavigationManager? navigationManger;

  NavigationManager();

  NavigationManager.getInstance() {
    navigationManger ??= NavigationManager();
  }

  Map<String, WidgetBuilder> getRouteTable() => {
        AddPlaceScreen.routeName: (context) => const AddPlaceScreen(),
        PlaceDetailScreen.routeName: (context) => const PlaceDetailScreen(),
      };
}
