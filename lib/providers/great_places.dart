import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/data/local/db_constants.dart';
import 'package:great_places/data/local/db_source.dart';
import 'package:great_places/data/models/place_location.dart';
import 'package:great_places/managers/location_manager.dart';

import '../data/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];

  final databaseSource = DatabaseSource.getInstance();

  Place findById(String id) => _items.firstWhere((place) => place.id == id);

  Future<void> addPlace(
    String title,
    File image,
    PlaceLocation pickedLocation,
  ) async {
    pickedLocation.address = await LocationManger.getPlaceAddress(
      pickedLocation.latitude,
      pickedLocation.longitude,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: pickedLocation,
      image: image,
    );
    _items.add(newPlace);
    notifyListeners();
    return databaseSource.insert(
        DbConstants.placesTable, _getDatabaseData(newPlace));
  }

  Map<String, Object> _getDatabaseData(Place place) => {
        MapKey.id: place.id,
        MapKey.title: place.title,
        MapKey.image: place.image.path,
        MapKey.latitude: place.location.latitude,
        MapKey.longitude: place.location.longitude,
        MapKey.address: place.location.address,
      };

  Future<void> fetchAndSetPlaces() async {
    final dataList = await databaseSource.getData(DbConstants.placesTable);
    _items = dataList.map((item) => generatePlace(item)).toList();
    notifyListeners();
  }

  Place generatePlace(Map<String, dynamic> item) => Place(
        id: item[MapKey.id],
        title: item[MapKey.title],
        location: PlaceLocation(
          latitude: item[MapKey.latitude],
          longitude: item[MapKey.longitude],
          address: item[MapKey.address],
        ),
        image: File(item[MapKey.image]),
      );
}
