import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manifest/core/utils/log_util.dart';
import 'package:manifest/helper/constant.dart';

class ImagePickerController extends GetxController {
  // Reactive variable for the picked image.
  final Rxn<File> pickedImage = Rxn<File>();

  /// Picks an image from the specified [imageSource] and then crops it.
  Future<void> pickImage({
    required BuildContext context,
    required ImageSource imageSource,
  }) async {
    try {
      final picker = ImagePicker();
      final XFile? xFile = await picker.pickImage(source: imageSource);
      if (xFile != null) {
        await _cropImage(xFile, context);
      }
    } catch (e) {
      LogUtil.log("Error picking image: $e");
      rethrow;
    }
  }

  /// Crops the image selected by the user and compresses it.
  Future<void> _cropImage(XFile file, BuildContext context) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 40,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Manifest Cropper',
            toolbarColor: primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
            showCropGrid: false,
            cropFrameColor: primaryColor,
            activeControlsWidgetColor: primaryColor,
          ),
          IOSUiSettings(
            title: 'Manifest Cropper',
          ),
        ],
      );
      if (croppedFile != null) {
        // Convert cropped result to File.
        final File fileFromCrop = File(croppedFile.path);
        // Compress the cropped file.
        final File compressedFile = await _compressFile(fileFromCrop);
        // Update reactive variable.
        pickedImage.value = compressedFile;
        LogUtil.log(
          'Compressed file size: ${compressedFile.lengthSync()} bytes',
        );
      }
    } catch (e) {
      LogUtil.log("Error cropping image: $e");
      rethrow;
    }
  }

  /// Compresses the provided [file] and returns the compressed file.
  Future<File> _compressFile(File file) async {
    try {
      final filePath = file.absolute.path;
      final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
      final splitted = filePath.substring(0, lastIndex);
      final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        outPath,
        quality: 30,
      );
      if (result == null) {
        throw Exception("Image compression failed.");
      }
      LogUtil.log('Original file size: ${file.lengthSync()} bytes');
      return File(result.path);
    } catch (e) {
      LogUtil.log("Error compressing image: $e");
      rethrow;
    }
  }
}
