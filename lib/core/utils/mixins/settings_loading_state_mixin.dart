import 'package:get/get.dart';

mixin SettingsLoadingStateMixin {
  final RxBool isInitialLoading = false.obs;
  final RxBool isSendingResults = false.obs;
    final RxBool isSendingSuggestions = false.obs;
        final RxBool isJoinNewsLetter = false.obs;
 final RxBool isReportBug = false.obs;

  void startInitialLoading() => isInitialLoading.value = true;
  void stopInitialLoading() => isInitialLoading.value = false;

    void startSendingResults() => isSendingResults.value = true;
  void stopSendingResults() => isSendingResults.value = false;

  void startSendingSuggestions() => isSendingSuggestions.value = true;
  void stopSendingSuggestions() => isSendingSuggestions.value = false;

   void startReportBug() => isReportBug.value = true;
  void stopReportBug() => isReportBug.value = false;

    void startJoinNewsLetter() => isJoinNewsLetter.value = true;
  void stopJoinNewsLetter() => isJoinNewsLetter.value = false;

}
