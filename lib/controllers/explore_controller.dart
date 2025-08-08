import 'dart:convert';
import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:manifest/helper/constant.dart';
import 'package:manifest/helper/dummy_data.dart';
import 'package:manifest/helper/import.dart';
import '../services/api_service.dart';
import '../view/widgets/snack_bar.dart';
import 'package:http/http.dart' as http;

class ExploreController extends GetxController {
  final RxInt _currTabIndex = 0.obs;
  int get getCurrTabIndex => _currTabIndex.value;
  void setCurrTabIndex(int index) {
    _currTabIndex.value = index;
    update();
  }

  RxInt volume = 50.obs;
  RxBool isMusicOn = false.obs;
  RxBool isVideoOn = false.obs;
  RxBool isDeleteLoading = false.obs;
  RxBool isRenameLoading = false.obs;
  void increaseVolume() {
    if (volume.value < 100) {
      volume.value++;
    }
  }

  void decreaseVolume() {
    if (volume.value > 0) {
      volume.value--;
    }
  }

  void toggleMusic() {
    isMusicOn.value = !isMusicOn.value;
  }

  void toggleVideo() {
    isVideoOn.value = !isVideoOn.value;
  }

  RxList<String> SecondfilterCategories = [
    'All',
    '👃  Nose',
    '👀  Eyes',
    '🦵  Legs',
    '🍈  Breast',
    '🍑  Hips',
  ].obs;

  RxList<String> filterCategories = [
    'All',
    'New',
    'Free',
    'Mix',
    'My Soundscape',
    'Uploaded'
  ].obs;

  // Index of the selected filter
  Rx<int?> selectedFilter = Rx<int?>(null);
  int get getSelectedFilter => selectedFilter.value ?? 0;
  final RxString _selectedFilterName = 'All'.obs;
  String get getSelectedFilterName => _selectedFilterName.value;
  void setSelectedFilter(int index) {
    _selectedFilterName.value = filterCategories[index];
  }

  ApiService apiService = ApiService();
  // List of filter results (image paths)
  RxList<String> filterResults = [
    'assets/images/result1.png',
    'assets/images/result2.png',
    'assets/images/result3.png',
    // Add more image paths as needed
  ].obs;
  RxList<Product> dummyData = [
    Product(
      imageUrl: 'https://source.unsplash.com/random/800x600',
      title: 'I Know I Can',
      description: '105 Affirmation',
      duration: '8:03:00', // Example duration
    ),
    Product(
      imageUrl: 'https://source.unsplash.com/random/800x600',
      title: 'Morning vibes',
      description: '3 Subliminal',
      duration: '55:00', // Example duration
    ),
    Product(
      imageUrl: 'https://source.unsplash.com/random/800x600',
      title: 'Product 3',
      description: 'Description of Product 3',
      duration: '2:30', // Example duration
    ),
    Product(
      imageUrl: 'https://source.unsplash.com/random/800x600',
      title: 'Product 4',
      description: 'Description of Product 4',
      duration: '5:00', // Example duration
    ),
    Product(
      imageUrl: 'https://source.unsplash.com/random/800x600',
      title: 'Product 5',
      description: 'Description of Product 5',
      duration: '3:15', // Example duration
    ),
  ].obs;

  /// * Delete Collection
  Future<void> deleteCollection(String collectionId) async {
    try {
      print('Starting to delete collection: $collectionId...');
      isDeleteLoading.value = true;
      var response = await apiService.request(
        apiEndPoint: '${ApiService.deleteCollection}/$collectionId',
        isGet: false,
        withToken: true,
        isDelete: true, // Assuming API supports DELETE request
      );
      print('API Response Status: ${response.statusCode}');
      print('API Response Body: ${response.body}');
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        LogUtil.v('Collection deleted successfully: ${data['message']}');
        // Remove from list if stored locally
      } else {
        ToastUtil.error(data['message']);
      }
    } catch (e) {
      LogUtil.e('Error while deleting collection: $e');
    } finally {
      isDeleteLoading.value = false;
    }
  }

  /// * Rename Collection
  Future<void> renameCollection(
      String collectionId, String newName, String? imagePath) async {
    try {
      print('Starting to rename collection: $collectionId...');
      isRenameLoading.value = true;
      // Ensure collectionId is valid
      if (collectionId.isEmpty) {
        LogUtil.e('Error: Collection ID is empty.');
        return;
      }
      // Define API URL
      var url = 'https://ops.manifest.so/api/collections/update/$collectionId';
      var uri = Uri.parse(url);
      print('API Request URL: $url');
      print(newName);
      var request = http.MultipartRequest("POST", uri)
        ..headers['Authorization'] =
            'Bearer ${LocalStorage.userAccessToken}' // Add auth token
        ..fields['name'] = newName; // Add new name
      // Debugging: Print Auth Token (avoid in production)
      if (kDebugMode) {
        print('Auth Token: ${LocalStorage.userAccessToken}');
      }
      // Check if imagePath is a local file or a URL
      if (imagePath != null && imagePath.isNotEmpty) {
        if (imagePath.startsWith('http')) {
          // If it's a URL, add it as a field
          request.fields['image'] = imagePath;
          print('Using image URL: $imagePath');
        } else {
          // If it's a local file, attach it as a file
          File imageFile = File(imagePath);
          if (await imageFile.exists()) {
            request.files.add(
                await http.MultipartFile.fromPath('image', imageFile.path));
            print('Attaching local image file: ${imageFile.path}');
          } else {
            LogUtil.e('Error: Local image file does not exist -> $imagePath');
            return;
          }
        }
      }
      // Send request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      // Debugging: Print API response details
      print('API Response Status: ${response.statusCode}');
      print('API Response Body: ${response.body}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        LogUtil.v('Collection renamed successfully: ${data['message']}');
      } else {
        var data = json.decode(response.body);
        LogUtil.e('Error: ${data['message']}');
        ToastUtil.error(data['message']);
      }
    } catch (e) {
      LogUtil.e('Error while renaming collection: $e');
    } finally {
      isRenameLoading.value = false;
    }
  }
}
