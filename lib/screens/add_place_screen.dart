import 'package:flutter/material.dart';
import 'package:great_places/utils/constants.dart';
import 'package:great_places/utils/dimensions.dart';
import 'package:great_places/widgets/image_input.dart';

import '../widgets/add_place_button.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = "/add_place";

  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();

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
                    const ImageInput(),
                  ],
                ),
              ),
            ),
          ),
          AddPlaceButton(onClick: () {})
        ],
      ),
    );
  }
}
