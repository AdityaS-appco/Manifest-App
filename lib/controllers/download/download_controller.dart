import 'package:get/get.dart';
import 'package:manifest/helper/dummy_data.dart';

class DownloadMainPageController extends GetxController {
  // Observable variables
  RxList<Product> downloads = <Product>[].obs;
  RxList<Product> filteredDownloads = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with dummy data
    downloads.assignAll(DummyData.dummyData);
    resetFilter();
  }

  void onSearchChanged(String query) {
    filteredDownloads.assignAll(
      downloads.where((item) {
        String title = item.title.toString().toLowerCase();
        return title.contains(query);
      }).toList(),
    );
  }

  void resetFilter() {
    filteredDownloads.assignAll(downloads);
  }

  void navigateToPlaylistOptions(int index) {
    if (index == 4) {
      Get.toNamed('/download-playlist-options');
    } else {
      Get.toNamed('/edit-recorded-affirmations');
    }
  }
}
