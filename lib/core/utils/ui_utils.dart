import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:manifest/core/utils/log_util.dart';

class UiUtils {
  /// * Converts a widget to an image bytes
  static Future<Uint8List?> convertWidgetToImage(GlobalKey key) async {
    try {
      RenderRepaintBoundary boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      LogUtil.e('Error converting widget to image: $e');
      return null;
    }
  }

  
} 