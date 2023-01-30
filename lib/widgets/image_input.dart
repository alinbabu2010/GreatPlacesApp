import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:great_places/utils/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  const ImageInput(
    this.onSelectImage, {
    Key? key,
  }) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture(BuildContext context) async {
    final imagePicker = ImagePicker();
    try {
      final imageFile = await imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
      );
      if (imageFile == null) return;
      setState(() {
        _storedImage = File(imageFile.path);
      });
      final appDir = await getApplicationDocumentsDirectory();
      final filename = basename((_storedImage?.path)!);
      final savedImage = await _storedImage?.copy('${appDir.path}/$filename');
      widget.onSelectImage(savedImage);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            kDebugMode ? error.toString() : Constants.somethingWrong,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

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
            onPressed: () => _takePicture(context),
          ),
        )
      ],
    );
  }
}
