import 'dart:io';

import 'package:get/get.dart';
import 'package:manifest/core/utils/log_util.dart';
import 'package:manifest/core/utils/toast_util.dart';
import 'package:appinio_social_share/appinio_social_share.dart';

class ShareService extends GetxService {
  static ShareService get to => Get.find<ShareService>();
  final AppinioSocialShare _socialShare = AppinioSocialShare();

  /// * Copies text to clipboard using AppinioSocialShare
  Future<void> copyToClipboard(String text) async {
    try {
      if (Platform.isAndroid) {
        await _socialShare.android.copyToClipBoard(text);
      } else {
        await _socialShare.iOS.copyToClipBoard(text);
      }
      ToastUtil.success('Link copied to clipboard');
    } catch (e) {
      LogUtil.e('Error copying to clipboard: $e');
      ToastUtil.error('Failed to copy link');
    }
  }

  /// * Shares content to Facebook with optional image and URL
  Future<void> shareToFacebook({
    required String text,
    required String imagePath,
    String? url,
  }) async {
    try {
      final shareText = _buildShareText(text, url);
      if (Platform.isAndroid) {
        await _socialShare.android.shareToFacebookStory(
          "1203195591235143",
          backgroundImage: imagePath,
          attributionURL: url,
        );
      } else {
        await _socialShare.iOS.shareToFacebookStory(
          "1203195591235143",
          backgroundImage: imagePath,
          attributionURL: url,
        );
      }
    } catch (e) {
      LogUtil.e('Error sharing to Facebook: $e');
      ToastUtil.error('Failed to share to Facebook');
    }
  }

  /// * Shares content to Instagram with optional image and URL
  Future<void> shareToInstagramFeed({
    required String text,
    String? imagePath,
    String? url,
  }) async {
    try {
      final shareText = _buildShareText(text, url);
      if (imagePath != null) {
        if (Platform.isAndroid) {
          await _socialShare.android.shareToInstagramFeed(
            shareText,
            imagePath,
          );
        } else {
          await _socialShare.iOS.shareToInstagramFeed(
            imagePath,
          );
        }
      } else {
        throw Exception('Failed to share to Instagram');
      }
    } catch (e) {
      LogUtil.e('Error sharing to Instagram: $e');
      ToastUtil.error('Failed to share to Instagram');
    }
  }

  /// * Shares content to X (Twitter) with optional image and URL
  Future<void> shareToX({
    required String text,
    String? imagePath,
    String? url,
  }) async {
    try {
      final shareText = _buildShareText(text, url);
      if (imagePath != null) {
        if (Platform.isAndroid) {
          await _socialShare.android.shareToTwitter(
            shareText,
            imagePath,
          );
        } else {
          await _socialShare.iOS.shareToTwitter(
            shareText,
            imagePath,
          );
        }
      } else {
        throw Exception('Failed to share to X');
      }
    } catch (e) {
      LogUtil.e('Error sharing to X: $e');
      ToastUtil.error('Failed to share to X');
    }
  }

  /// * Opens system share dialog with optional image and URL
  Future<void> shareMore({
    required String text,
    String? imagePath,
    String? url,
  }) async {
    try {
      final shareText = _buildShareText(text, url);
      if (imagePath != null) {
        if (Platform.isAndroid) {
          await _socialShare.android.shareToSystem(
            shareText,
            url ?? '',
            imagePath,
          );
        } else {
          await _socialShare.iOS.shareToSystem(
            shareText,
            filePaths: [imagePath],
          );
        }
      } else {
        if (Platform.isAndroid) {
          await _socialShare.android.shareToSystem(
            shareText,
            url ?? '',
            null,
          );
        } else {
          await _socialShare.iOS.shareToSystem(
            shareText,
          );
        }
      }
    } catch (e) {
      LogUtil.e('Error sharing: $e');
      ToastUtil.error('Failed to share');
    }
  }

  /// * Builds the final share text by combining text and URL
  String _buildShareText(String text, String? url) {
    if (url != null) {
      return '$text\n$url';
    }
    return text;
  }
}
