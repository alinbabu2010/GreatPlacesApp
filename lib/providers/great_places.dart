import 'package:flutter/material.dart';

import '../data/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];
}
