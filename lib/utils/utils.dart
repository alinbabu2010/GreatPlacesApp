import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'constants.dart';

class Utils {

  static Future<File?> takeAndSavePicture() async {
    final imagePicker = ImagePicker();
    try {
      final imageFile = await imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
      );
      if (imageFile == null) return null;
      final storedImage = File(imageFile.path);
      final appDir = await getApplicationDocumentsDirectory();
      final filename = basename(storedImage.path);
      return await storedImage.copy('${appDir.path}/$filename');
    } catch (error) {
      rethrow;
    }
  }

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          kDebugMode ? message : Constants.somethingWrong,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

}