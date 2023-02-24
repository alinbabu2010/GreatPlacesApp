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
      style: ElevatedButton.styleFrom(
        elevation: 0,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Colors.black,
        shape: const ContinuousRectangleBorder(),
        padding: const EdgeInsets.symmetric(
          vertical: Dimensions.addBtnVerticalPadding,
        ),
      ),
    );
  }
}
