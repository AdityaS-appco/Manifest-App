import 'package:get/get.dart';
import 'package:manifest/core/shared/controllers/profile_controller.dart';
import 'package:manifest/features/notification/models/notification_model.dart';
import 'package:manifest/services/api_service.dart';
import 'package:manifest/core/base/base_service.dart';

/// Service for handling notification-related operations
class NotificationService extends BaseService {
  NotificationService();

  /// persistent notifications list
  final RxList<NotificationModel> notifications = RxList.empty();

  /// count of unread notifications
  final RxInt unreadCount = 0.obs;

  /// get notifications list when controller is initialized
  // @override
  // Future<void> onInit() async {
  //   super.onInit();
  //   await getNotifications();
  // }

  /// Get all notifications
  /// Returns a map containing success status and list of notifications
  Future<Map<String, dynamic>> getNotifications({
    bool showLoader = true,
    int? userId,
  }) async {
    final response = await makeRequest(
      endpoint:
          '${ApiService.getNotifications}/$userId',
      isGet: true,
      withToken: false,
    );

    // final Map<String, dynamic> response = {
    //   'success': true,
    //   'data': {
    //     'data': [
    //       {
    //         'id': 1,
    //         'user_id': 101,
    //         'title': 'Explore what\'s new on the july update',
    //         'description': 'What’s New in the July Update\nWe’ve added powerful new features to enhance your affirmation journey:\n'
    //                        '• Mind Movies – Visualize your dreams with guided affirmation videos.\n'
    //                        '• Manifestation Booster – Amplify your intentions with enhanced manifestation techniques.\n'
    //                        '• Deep Focus Mode – Immerse yourself in affirmations with calming soundscapes.\n'
    //                        '• Daily Personalized Affirmations – Receive affirmations tailored just for you.\n'
    //                        '• Bug Fixes & Optimizations – Enjoy a smoother and more seamless experience.\n'
    //                        'Update now and start manifesting your best life!',
    //         'notification_type': 'update',
    //         'created_at': DateTime.now().toIso8601String(),
    //         'updated_at': DateTime.now().toIso8601String(),
    //         'is_read': false,
    //       },
    //       {
    //         'id': 2,
    //         'user_id': 102,
    //         'title': 'Try our new Manifestation booster feature',
    //         'description': 'Try our new Manifestation booster feature',
    //         'notification_type': 'feature',
    //         'created_at': DateTime.now().toIso8601String(),
    //         'updated_at': DateTime.now().toIso8601String(),
    //         'is_read': false,
    //       },
    //       {
    //         'id': 3,
    //         'user_id': 103,
    //         'title': 'Your purchase of Manifest+ was successful',
    //         'description': 'Your purchase of Manifest+ was successful',
    //         'notification_type': 'purchase',
    //         'created_at': DateTime.now().toIso8601String(),
    //         'updated_at': DateTime.now().toIso8601String(),
    //         'is_read': true,
    //       },
    //     ],
    //   },
    // };

    if (response['success']) {
      notifications.value = ((response['data']['data'] ?? []) as List)
          .map((e) => NotificationModel.fromJson(e))
          .toList();

      // Update unread count
      unreadCount.value = notifications.where((n) => !n.isRead).length;
    }

    return response;
  }

  /// Get notification details by ID
  /// Returns a specific notification or null if not found
  Future<NotificationModel?> getNotificationById(int notificationId,
      {bool showLoader = true}) async {
    final response = await makeRequest(
      endpoint: '${ApiService.getNotifications}/$notificationId',
      isGet: true,
      withToken: false,
    );

    if (response['success']) {
      final notification = NotificationModel.fromJson(response['data']['data']);
      return notification;
    }

    return null;
  }

  /// Mark notification as read
  /// Returns a map containing success status and message
  Future<Map<String, dynamic>> markAsRead(int notificationId) async {
    final response = await makeRequest(
      endpoint: "${ApiService.markNotificationAsRead}/$notificationId",
      isPost: true,
    );

    if (response['success']) {
      // Update notification in local list
      final index = notifications.indexWhere((n) => n.id == notificationId);
      if (index != -1) {
        final updatedNotification = notifications[index].copyWith(isRead: true);
        notifications[index] = updatedNotification;

        // Update unread count
        unreadCount.value = notifications.where((n) => !n.isRead).length;
      }
    }

    return response;
  }
}
