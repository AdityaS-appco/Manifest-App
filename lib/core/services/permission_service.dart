// * @author: alok singh
// * @description: permission service

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool> requestAudioFileAccessPermission() async {
    // For Android 13 and above
    if (await _isAndroid13OrAbove()) {
      final audio = await Permission.audio.request();
      if (audio.isGranted) return true;
      
      // If denied, show settings dialog
      if (audio.isPermanentlyDenied) {
        await openAppSettings();
      }
      return false;
    }
    
    // For Android 12 and below
    final storage = await Permission.storage.request();
    if (storage.isGranted) return true;
    
    // If denied, show settings dialog
    if (storage.isPermanentlyDenied) {
      await openAppSettings();
    }
    return false;
  }

  static Future<bool> requestMicrophonePermission() async {
    final microphone = await Permission.microphone.request();
    if (microphone.isGranted) return true;
    
    // If denied, show settings dialog
    if (microphone.isPermanentlyDenied) {
      await openAppSettings();
    }
    return false;
  }

  static Future<bool> _isAndroid13OrAbove() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      return androidInfo.version.sdkInt >= 33;
    }
    return false;
  }

  static Future<bool> hasStoragePermission() async {
    if (await _isAndroid13OrAbove()) {
      return await Permission.audio.isGranted;
    }
    return await Permission.storage.isGranted;
  }
}
