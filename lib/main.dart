import 'package:flutter/material.dart';
import 'package:great_places/managers/navigation_manager.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/places_list_screen.dart';
import 'package:great_places/utils/constants.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final navigationHelper = NavigationManager.getInstance();
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: Constants.greatPlaces,
        theme: ThemeData(
            colorScheme: const ColorScheme.light(
          primary: Colors.indigo,
          secondary: Colors.amber,
        )),
        home: const PlacesListScreen(),
        routes: navigationHelper.getRouteTable(),
      ),
    );
  }
}
