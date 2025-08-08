import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manifest/core/utils/log_util.dart';
import 'package:manifest/features/explore/models/image_with_metadata.dart';
import 'package:manifest/features/playlist/by_you/models/local_affirmation.dart';
import 'package:manifest/core/l10n/app_strings.dart';

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return '${duration.inHours > 0 ? '${duration.inHours}:' : ''}$twoDigitMinutes:$twoDigitSeconds';
}

String formatTotalDuration(List<LocalAffirmation> affirmations) {
  final totalDuration = affirmations.fold<Duration>(
    Duration.zero,
    (total, affirmation) => total + affirmation.duration,
  );

  final minutes = totalDuration.inMinutes;
  final seconds = totalDuration.inSeconds % 60;
  return '$minutes:${seconds.toString().padLeft(2, '0')}';
}

/// * Get affirmation count string
String getAffirmationCountString(int? affirmationCount) {
  if (affirmationCount == null) return '0 affirmations';
  if (affirmationCount == 1) return '$affirmationCount affirmation';
  return '$affirmationCount affirmations';
}

/// * Get track count string
String getTrackCountString(int? trackCount) {
  if (trackCount == null) return '0 tracks';
  if (trackCount == 1) return '$trackCount track';
  return '$trackCount tracks';
}

/// * get affirmation count with total affirmation duration string
String getAffirmationCountWithTotalDurationString(
    int? count, String? duration) {
  return '${getAffirmationCountString(count)} | ${duration ?? '00:00'}';
}

/// * get greeting based on time [good morning, good afternoon, good evening]
String getGreeting() {
  final time = DateTime.now().hour;
  if (time < 12) return AppStrings.goodMorning;
  if (time < 17) return AppStrings.goodAfternoon;
  return AppStrings.goodEvening;
}

/// * get greeting icon based on time [🌤, 🌞, 🌚]
String getGreetingIcon() {
  final time = DateTime.now().hour;
  if (time < 12) return "🌤";
  if (time < 17) return "🌞";
  return "🌚";
}

/// * convert minutes into time string "9:30 AM"
String convertMinutesToTimeAMPMString(int minutes) {
  final hourFormat24 = (minutes / 60).floor();
  final hour = ((minutes / 60) % 12).floor();
  final minute = minutes % 60;
  final amPm = hourFormat24 < 12 ? 'AM' : 'PM';
  return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $amPm';
}

const dotChar = "·";

/// * convert seconds integer value in "00:00:00" string format
String formatSecondsToDurationString(int? seconds) {
  if (seconds == null || seconds == 0) return "00:00";

  final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
  final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
  final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');

  if (hours == '00') {
    return '$minutes:$remainingSeconds';
  }
  return '$hours:$minutes:$remainingSeconds';
}

String timeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  // Less than a minute
  if (difference.inSeconds < 60) {
    return 'Just now';
  }

  // Less than an hour
  if (difference.inMinutes < 60) {
    return '${difference.inMinutes} min ago';
  }

  // Less than a day
  if (difference.inHours < 24) {
    return '${difference.inHours} hr ago';
  }

  // Less than a week
  if (difference.inDays < 7) {
    return '${difference.inDays} days ago';
  }

  // Less than a month (approximated as 30 days)
  if (difference.inDays < 30) {
    final weeks = (difference.inDays / 7).floor();
    return '$weeks week${weeks > 1 ? 's' : ''} ago';
  }

  // Less than a year
  if (difference.inDays < 365) {
    final months = (difference.inDays / 30).floor();
    return '$months month${months > 1 ? 's' : ''} ago';
  }

  // More than a year
  final years = (difference.inDays / 365).floor();
  return '$years year${years > 1 ? 's' : ''} ago';
}

/// * format date from string into MMM dd, yyyy
String formatDateFromStringIntoMMMddyyyy(String? date) {
  if (date == null) return '';
  return DateFormat('MMM dd, yyyy').format(DateTime.parse(date));
}

BorderRadius? adjustedBorderRadius(
    BorderRadius? outerRadius, EdgeInsets padding) {
  if (outerRadius == null) return null;

  return BorderRadius.only(
    topLeft: Radius.circular(
      max(outerRadius.topLeft.x - padding.left, 0),
    ),
    topRight: Radius.circular(
      max(outerRadius.topRight.x - padding.right, 0),
    ),
    bottomLeft: Radius.circular(
      max(outerRadius.bottomLeft.x - padding.left, 0),
    ),
    bottomRight: Radius.circular(
      max(outerRadius.bottomRight.x - padding.right, 0),
    ),
  );
}

/// * Determines the type of image from the URL
ImageType getImageType(String? url) {
  if (url == null || url.isEmpty) {
    return ImageType.asset;
  }

  if (url.startsWith('http://') || url.startsWith('https://')) {
    return ImageType.network;
  }

  try {
    final file = File(url);
    if (file.existsSync()) {
      return ImageType.file;
    }
  } catch (e) {
    LogUtil.e('Error checking file: $e');
  }

  return ImageType.asset;
}

/// Enum for different image types to be displayed
enum ImageType {
  asset,
  file,
  network,
}

/// * Format timer in MM:SS format
String formatTimer(int seconds) {
  int minutes = seconds ~/ 60;
  int remainingSeconds = seconds % 60;
  String minutesStr = (minutes < 10) ? '0$minutes' : '$minutes';
  String secondsStr =
      (remainingSeconds < 10) ? '0$remainingSeconds' : '$remainingSeconds';
  return '$minutesStr:$secondsStr';
}

/// * parse aspect ratio from string into double
double parseAspectRatio(String ratio) {
  final parts = ratio.split(':');
  if (parts.length == 2) {
    final width = double.tryParse(parts[0]) ?? 1.0;
    final height = double.tryParse(parts[1]) ?? 1.0;
    return width / height;
  }
  return 1.0; // fallback to square if parsing fails
}

/// * Format duration string to remove unnecessary leading zeros
String formatDurationString(String duration) {
  // Split the duration string into hours, minutes, and seconds
  final parts = duration.split(':');

  // If the duration has 3 parts (hours:minutes:seconds)
  if (parts.length == 3) {
    final hours = int.tryParse(parts[0]) ?? 0;
    final minutes = int.tryParse(parts[1]) ?? 0;
    final seconds = int.tryParse(parts[2]) ?? 0;

    // If hours are 0, return minutes:seconds
    if (hours == 0) {
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }

    // If hours are non-zero, return full duration
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // If the duration doesn't have 3 parts, return as is
  return duration;
}

/// * Format duration string to remove unnecessary leading zeros
Duration stringToDuration(String? duration) {
  if(duration == null) return Duration.zero;

  // Split the duration string into hours, minutes, and seconds
  final parts = duration.trim().split(':');

  // If the duration has 3 parts (hours:minutes:seconds)
  if (parts.length == 3) {
    final hours = int.tryParse(parts[0]) ?? 0;
    final minutes = int.tryParse(parts[1]) ?? 0;
    final seconds = int.tryParse(parts[2]) ?? 0;

    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  } else if (parts.length == 2) {
    final minutes = int.tryParse(parts[0])?? 0;
    final seconds = int.tryParse(parts[1])?? 0;
    return Duration(minutes: minutes, seconds: seconds);
  }

  return Duration.zero;
}

/// * Safely parse image URL or return null based on file extension
///
ImageData? parseImageData(dynamic imageData) {
  if (imageData != null &&
      imageData is Map<String, dynamic> &&
      !['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp']
          .contains(imageData['imageName']?.split('.').last.toLowerCase())) {
    return ImageData.fromJson(imageData);
  }
  return null;
}
