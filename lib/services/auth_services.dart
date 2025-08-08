import 'package:get/get.dart';
import 'package:manifest/core/base/base_service.dart';
import 'package:manifest/core/utils/log_util.dart';
import 'package:manifest/core/services/firebase_notification_service.dart';
import 'package:manifest/core/services/reminder_service.dart';
import 'package:manifest/core/utils/enums/days_of_week.enum.dart';
import 'package:manifest/core/utils/loading_util.dart';
import 'package:manifest/helper/local_storage.dart';
import 'package:manifest/services/dependency_injection.dart';
import 'api_service.dart';
import 'package:manifest/core/services/profile_service.dart';

class AuthService extends BaseService {
  final ProfileService _profileService;
  final FirebaseNotificationService _notificationService;

  AuthService(this._profileService, this._notificationService);

  /// * guest login
  Future<bool> loginAsGuest() async {
    try {
      /// ! Guest Login
      /// * 1. check whether or not the token is empty
      /// * if token is empty,
      /// *  - get device_id
      /// *  - register with device_id
      /// *  - save the token received in response to the local storage
      /// *
      /// * do anyways
      /// *  - fetch user data with token
      /// *  - persist the user data to profileService
      if (LocalStorage.deviceID.isEmpty) {
        /// * get device id
        await DependencyInjection().getDeviceId();
      }

      /// * register with device id [if login token is empty or is not social login]
      if (LocalStorage.userAccessToken.isEmpty) {
        String deviceID = LocalStorage.deviceID.toString();

        final response = await makeRequest(
          isPost: true,
          endpoint: ApiService.registerWithEmail,
          data: {
            "device_id": deviceID,
            "fcm_token": _notificationService.token
          },
        );

        /// * save token to local storage
        if (response['success']) {
          LocalStorage.setLoginToken(response['data']['data']['token']);
        }
      }

      /// * fetch user data with token & persist in the profileService
      await _profileService.getProfile();
      // if (_profileService.profile?.data?.id != null) {
      //   return true;
      // }
    } catch (e) {
      LogUtil.log(e.toString());
    }
    return false;
  }


  Future<void> loginAsGuestAndSetReminder() async {
    LoadingUtil.show();

    /// * wait and login as guest
    await loginAsGuest();

    /// * set initial reminder to the server if user has set
    await setInitialReminder();

    LoadingUtil.dismiss();
  }

  Future<void> setInitialReminder() async {
    final reminderService = Get.find<ReminderService>();

    /// * if user has set the reminder then set it in the server
    if (reminderService.isReminderSet) {
      /// * get initial reminder from local storage
      final (DateTime reminderStartTime, DateTime reminderEndTime, RxSet<DaysOfWeek> daysOfWeek, int notificationPerDayCount) =
          LocalStorage.getInitialReminder();

      /// * set a regular reminder
      // await reminderService.setRegularReminder(
      //   reminderStartTime: reminderStartTime,
      //   reminderEndTime: reminderEndTime,
      //   daysOfWeek: daysOfWeek,
      //   notificationPerDayCount: 1,
      // );
    }
  }
}
