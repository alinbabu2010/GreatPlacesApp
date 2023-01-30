import 'package:flutter/material.dart';
import 'package:great_places/utils/dimensions.dart';

import '../utils/constants.dart';

class AddPlaceButton extends StatelessWidget {
  final Function onClick;

  const AddPlaceButton({
    super.key,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.add),
      label: const Text(Constants.addPlace),
      onPressed: () => onClick(),
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: MaterialStatePropertyAll(
          Theme.of(context).colorScheme.secondary,
        ),
        foregroundColor: const MaterialStatePropertyAll(Colors.black),
        shape: const MaterialStatePropertyAll(
          ContinuousRectangleBorder(),
        ),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(vertical: Dimensions.addBtnVerticalPadding),
        ),
      ),
    );
  }
}
