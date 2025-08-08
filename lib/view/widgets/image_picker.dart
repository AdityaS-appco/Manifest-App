import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageUtils {
  static Future<XFile?> pickImage({required BuildContext context, required ImageSource imageSource}) async {
    final picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: imageSource);
    return pickedImage;
  }

  static Future<File?> cropImage(XFile file, BuildContext context) async {
    var croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 40,
    );
    return croppedFile != null ? File(croppedFile.path) : null;
  }

  static Future<File?> compressImage(File file) async {
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: 30,
    );

    return result != null ? File(result.path) : null;
  }
}
