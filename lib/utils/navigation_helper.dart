import 'package:flutter/material.dart';
import 'package:great_places/screens/add_place_screen.dart';

class NavigationHelper {
  NavigationHelper? navigationHelper;

  NavigationHelper();

  NavigationHelper.getInstance() {
    navigationHelper ??= NavigationHelper();
  }

  Map<String, WidgetBuilder> getRouteTable() => {
        AddPlaceScreen.routeName: (context) => const AddPlaceScreen(),
      };
}
