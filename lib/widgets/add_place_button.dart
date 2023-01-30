import 'package:flutter/material.dart';

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
      onPressed: onClick(),
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: MaterialStatePropertyAll(
          Theme.of(context).colorScheme.secondary,
        ),
        shape: const MaterialStatePropertyAll(
          ContinuousRectangleBorder(),
        ),
      ),
    );
  }
}
