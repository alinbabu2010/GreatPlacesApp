import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/data/local/db_source.dart';
import 'package:great_places/data/models/place_location.dart';

import '../data/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];

  final databaseSource = DatabaseSource.getInstance();

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: PlaceLocation(latitude: 0.0, longitude: 0.0),
      image: image,
    );
    _items.add(newPlace);
    notifyListeners();
    databaseSource.insert("places", {
      'id': newPlace.id,
      "title": newPlace.title,
      'image': newPlace.image.path,
    });
  }
}
