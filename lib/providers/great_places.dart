import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/data/local/db_constants.dart';
import 'package:great_places/data/local/db_source.dart';
import 'package:great_places/data/models/place_location.dart';

import '../data/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];

  final databaseSource = DatabaseSource.getInstance();

  Future<void> addPlace(String title, File image) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: PlaceLocation(latitude: 0.0, longitude: 0.0),
      image: image,
    );
    _items.add(newPlace);
    notifyListeners();
    return databaseSource.insert(DbConstants.placesTable, {
      MapKey.id: newPlace.id,
      MapKey.title: newPlace.title,
      MapKey.image: newPlace.image.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await databaseSource.getData(DbConstants.placesTable);
    _items = dataList
        .map((item) => Place(
              id: item[MapKey.id],
              title: item[MapKey.title],
              location: PlaceLocation(latitude: 0.0, longitude: 0.0),
              image: File(item[MapKey.image]),
            ))
        .toList();
    notifyListeners();
  }

}
