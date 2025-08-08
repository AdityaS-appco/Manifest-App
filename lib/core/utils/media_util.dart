import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manifest/helper/import.dart';

class MediaUtil {
  static Future<File?> pickAndCropImage({
    required ImageSource imageSource,
  }) async {
    final picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: imageSource);
    
    if (pickedImage == null) return null;

    return await cropImage(pickedImage, Get.context!);
  }

  static Future<File?> cropImage(XFile file, BuildContext context) async {
    var croppedFile = await ImageCropper().cropImage(
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

    if (croppedFile == null) return null;

    File pickedImage = File(croppedFile.path);
    return await compressFile(pickedImage);
  }

  static Future<File> compressFile(File file) async {
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: 30,
    );

    LogUtil.v('Original file size: ${file.lengthSync()}');
    LogUtil.v('Compressed file size: ${result!.length().then((value) => value).toString()}');

    return File(result.path);
  }
} 