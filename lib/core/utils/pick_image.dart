import 'dart:io';

import 'package:image_picker/image_picker.dart';

final _imgPicker = ImagePicker();

Future<File?> pickImage() async {
  try {
    final xFile = await _imgPicker.pickImage(
      source: ImageSource.gallery,
    );

    if (xFile == null) return null;

    return File(xFile.path);
  } catch (e) {
    return null;
  }
}
