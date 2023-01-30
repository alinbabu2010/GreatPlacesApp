import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/utils/constants.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Row(
      children: [
        Container(
          height: mediaQuery.size.width * 0.5,
          width: mediaQuery.size.width * 0.5,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  Constants.noImage,
                  textAlign: TextAlign.center,
                ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            icon: const Icon(Icons.camera),
            label: const Text(Constants.takeImage),
            style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.primary,
              ),
            ),
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
