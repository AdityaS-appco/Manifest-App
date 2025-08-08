import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:manifest/core/base/base_service.dart';
import 'package:manifest/core/utils/log_util.dart';
import 'package:manifest/core/utils/enums/days_of_week.enum.dart';
import 'package:manifest/features/reminder/models/reminder_model.dart';
import 'package:manifest/helper/local_storage.dart';
import 'package:manifest/services/api_service.dart';

class ReminderService extends BaseService {
  final RxList<ReminderModel> reminders = RxList<ReminderModel>();

  bool get isReminderSet => LocalStorage.isInitialReminderSet;

  Rx<Map<String, dynamic>> initialReminder = Rx<Map<String, dynamic>>({});

  /// * get all the reminders
  Future<List<ReminderModel>> getReminders({
    bool showLoader = false,
    int? userId,
  }) async {
    try {
      final response = await makeRequest(
        isGet: true,
        endpoint: "${ApiService.getReminders}?user_id=$userId",
        withToken: true,
      );

      final reminderResponse = RemindersResponse.fromJson(response['data']);

      reminders.value = reminderResponse.data;
      return reminders.value;
    } catch (e) {
      LogUtil.log('Error fetching reminders: $e');
      rethrow;
    }
  }

  /// * activate/deactivate the reminder (both custom & regular)
  Future<void> toggleReminder(ReminderModel reminder) async {
    try {
      final response = await makeRequest(
        endpoint: "${ApiService.updateReminder}/${reminder.id}",
        isPost: true,
        withToken: true,
        data: reminder.copyWith(isActive: !reminder.isActive).toJson(),
      );

      /// * update the specific reminder in the list
      if (response['success']) {
        final updatedReminder =
            reminder.copyWith(isActive: response['data']['data']['is_active']);
        reminders[reminders.indexWhere((e) => e.id == reminder.id)] =
            updatedReminder;
      }
    } catch (e) {
      LogUtil.log('Error toggling reminder: $e');
      rethrow;
    }
  }

  String _getReminderFrequency(Set<DaysOfWeek> daysOfWeek) {
    return daysOfWeek.length == 7 ? "daily" : "weekly";
  }

  String _formatDaysOfWeek(Set<DaysOfWeek> daysOfWeek) {
    return daysOfWeek.map((e) => e.weekDay).join(',');
  }

  String _formatTimeForApi(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  /// * set a regular reminder
  Future<Map<String, dynamic>> setRegularReminder({
    required DateTime reminderStartTime,
    required DateTime reminderEndTime,
    required Set<DaysOfWeek> daysOfWeek,
    required int notificationPerDayCount,
    required int? userId,
  }) async {
    final currentTimezone = await FlutterTimezone.getLocalTimezone();

    final body = {
      "frequency": _getReminderFrequency(daysOfWeek),
      "days_of_week": _formatDaysOfWeek(daysOfWeek),
      "timezone": currentTimezone,
      "user_id": userId,
      "start_time": _formatTimeForApi(reminderStartTime),
      "end_time": _formatTimeForApi(reminderEndTime),
      "notifications_per_day": notificationPerDayCount,
    };

    final response = await makeRequest(
      endpoint: ApiService.setRegularReminder,
      data: body,
      isPost: true,
      withToken: true,
    );

    await getReminders();
    return response;
  }

  /// * set a custom reminder
  Future<Map<String, dynamic>> setCustomReminder({
    required DateTime startTime,
    required DateTime endTime,
    required int notificationsPerDay,
    required Set<DaysOfWeek> daysOfWeek,
    required String affirmationText,
    required int? userId,
  }) async {
    final currentTimezone = await FlutterTimezone.getLocalTimezone();

    final body = {
      "start_time": _formatTimeForApi(startTime),
      "end_time": _formatTimeForApi(endTime),
      "notifications_per_day": notificationsPerDay,
      "frequency": _getReminderFrequency(daysOfWeek),
      "days_of_week": _formatDaysOfWeek(daysOfWeek),
      "affirmation": affirmationText,
      "timezone": currentTimezone,
      "user_id": userId,
    };

    final response = await makeRequest(
      endpoint: ApiService.setCustomReminder,
      data: body,
      isPost: true,
      withToken: true,
    );

    await getReminders();
    return response;
  }

  /// * update a reminder
  Future<Map<String, dynamic>> updateReminder({
    required ReminderModel reminder,
  }) async {
    Map<String, dynamic> body = {
      "timezone": reminder.timezone,
      "is_active": reminder.isActive,
    };

    if (reminder is RegularReminderModel) {
      body.addAll({
        "type": reminder.type,
        "reminder_time": reminder.reminderTime != null
            ? _formatTimeForApi(reminder.reminderTime!)
            : null,
        "frequency": reminder.frequency,
        "days_of_week": reminder.daysOfWeek,
        // Set all custom fields to null
        "start_time": null,
        "end_time": null,
        "notifications_per_day": null,
        "affirmation": null,
      });
    } else if (reminder is CustomReminderModel) {
      body.addAll({
        "type": reminder.type,
        "reminder_time": null,
        "start_time": reminder.startTime != null
            ? _formatTimeForApi(reminder.startTime!)
            : null,
        "end_time": reminder.endTime != null
            ? _formatTimeForApi(reminder.endTime!)
            : null,
        "notifications_per_day": reminder.notificationsPerDay,
        "affirmation": reminder.affirmation,
        "frequency": reminder.frequency,
        "days_of_week": reminder.daysOfWeek,
      });
    }

    LogUtil.log("""
\nUpdating Reminder ${reminder.id}
Type: ${reminder.type}
Body: $body
  """);

    final response = await makeRequest(
      endpoint: "${ApiService.updateReminder}/${reminder.id}",
      data: body,
      isPost: true,
      withToken: true,
    );

    /// * update the specific reminder in the list
    if (response['success']) {
      ReminderModel updatedReminder;
      if (response['data']['data']['type'] == 'regular') {
        updatedReminder =
            RegularReminderModel.fromJson(response['data']['data']);
      } else {
        updatedReminder =
            CustomReminderModel.fromJson(response['data']['data']);
      }
      reminders[reminders.indexWhere((e) => e.id == reminder.id)] =
          updatedReminder;
    }
    return response;
  }

  /// * delete a reminder
  Future<void> deleteReminder(int reminderId) async {
    final response = await makeRequest(
      endpoint: "${ApiService.deleteReminder}/$reminderId",
      isDelete: true,
      withToken: false,
    );

    if (response['success']) {
      reminders.removeWhere((element) => element.id == reminderId);
    }
  }
}
