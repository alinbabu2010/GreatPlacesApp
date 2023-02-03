import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:great_places/data/models/place_location.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/utils/constants.dart';
import 'package:great_places/utils/dimensions.dart';
import 'package:great_places/widgets/image_input.dart';
import 'package:great_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

import '../widgets/add_place_button.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = "/add_place";

  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLocation;

  void _selectPlace(double latitude, double longitude) {
    _pickedLocation = PlaceLocation(latitude: latitude, longitude: longitude);
  }

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!, _pickedLocation!)
        .then((_) => Navigator.of(context).pop())
        .catchError(
          (error) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  kDebugMode ? error.toString() : Constants.somethingWrong),
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.addNewPlace),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.addPlacePadding),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        labelText: Constants.title,
                      ),
                      controller: _titleController,
                    ),
                    const SizedBox(height: Dimensions.addPlaceBoxHeight),
                    ImageInput(_selectImage),
                    const SizedBox(height: Dimensions.addPlaceBoxHeight),
                    LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          AddPlaceButton(onClick: _savePlace)
        ],
      ),
    );
  }
}
