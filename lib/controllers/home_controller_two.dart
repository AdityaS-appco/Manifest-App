import 'dart:convert';
import 'package:manifest/core/shared/controllers/profile_controller.dart';
import 'package:manifest/controllers/recent_played.dart';
import 'package:manifest/core/shared/widgets/dialogs/app_dialogs.dart';
import 'package:manifest/core/utils/mixins/profile_controller_mixin.dart';
import 'package:manifest/features/paywall/manifest_entity.dart';
import 'package:manifest/helper/dummy_data.dart';
import 'package:manifest/models/home_model.dart';
import 'package:manifest/services/api_service.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/navbar_screens/home/models/home_data_model_by_alok.dart';

class HomeTwoController extends GetxController with ProfileControllerMixin {
  @override
  void onInit() async {
    super.onInit();
    await recentTracksController.loadRecentTracks();

    await _extractDominantColor();

    scrollController.addListener(_onScroll);

    /// * fetch home data
    fetchHomeData();
  }

  // * @author: alok singh
  // * @description: extract dominant color
  final colorExtractor =
      Get.put(ColorExtractorController(), tag: 'home_controller');
  final recentTracksController = Get.put(RecentTracksController());

  // * Scroll controller and offset for parallax effect
  final ScrollController scrollController = ScrollController();
  RxDouble scrollOffset = 0.0.obs;

  // Gradient animation values
  RxDouble gradientStartStop = 0.3.obs;
  RxDouble gradientMiddleStop = 0.6.obs;
  RxDouble gradientEndStop = 1.0.obs;

  Future<void> _extractDominantColor() async {
    await colorExtractor
        .extractColorsFromAssetImage('assets/images/HomePage_image.jpeg');
  }

  // Home Screen .... Main Screen
  var containerHeight = 0.0.obs;

  // height of home
  void updateContainerHeight(double height) {
    containerHeight.value = height;
  }

  var isAppBarVisible = true.obs;
  var topEleven = 0.0.obs;
  var isScrollingUp = false.obs;
  var isColorVisible = false.obs;

  void updateAppBarVisibility(double scrollPosition, double screenHeight) {
    if (scrollPosition > screenHeight * 0.38) {
      isAppBarVisible.value = false;
    } else {
      isAppBarVisible.value = true;
    }
  }

  void updateScrollState(
      double scrollDelta, double scrollPosition, double extentTotal) {
    topEleven.value -= scrollDelta / 1;
    if (scrollDelta >= 0) {
      isScrollingUp.value = true;
      isColorVisible.value = true;
    } else {
      isScrollingUp.value = false;
      if (scrollPosition >= extentTotal) {
        isColorVisible.value = false;
      } else {
        Future.delayed(const Duration(milliseconds: 200), () {
          isColorVisible.value = false;
        });
      }
    }
  }

  // .......................

  // theme change ...........
  ThemeController themeController = Get.find<ThemeController>();
  // .................

  RxBool isVideoOn = false.obs;
  RxBool isMusicOn = true.obs;
  RxBool switchValue = false.obs;
  RxInt volume = 50.obs;

  void toggleMusic() {
    isMusicOn.value = !isMusicOn.value;
  }

  void toggleSwitch() {
    switchValue.toggle();
  }

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

  void toggleVideo() {
    isVideoOn.value = !isVideoOn.value;
  }

  RxList<String> filterCategories = [
    AppStrings.all,
    AppStrings.live,
    AppStrings.scenery,
    AppStrings.texture,
    AppStrings.life,
    AppStrings.blind,
  ].obs;

  // Index of the selected filter
  Rx<int?> selectedFilter = Rx<int?>(null);

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

  ApiService apiService = ApiService();

  // ! @author: alok singh
  // ! @description: refactor the model to the new model as per the api response changes (12-12-2024)
  final Rx<HomeModel> _homeModel = HomeModel().obs;
  HomeModel get homeModel => _homeModel.value;

  Rx<HomeDataModelByAlok> homeDataModel = HomeDataModelByAlok().obs;

  Future<void> showDialog() async {
    await AppDialogs.showDiscordCommunity(onJoinPressed: () {
      /// Todo: 1. navigate to discord

      /// Todo: 2. close the dialog
      Get.back();
    });

    /// Todo: 3. open the showNewReleases dialog
    await AppDialogs.showNewReleases(
      entities: [
        ManifestEntity(
          id: '1',
          title: 'Affirmation',
          type: ManifestEntityType.affirmation,
          image: "https://picsum.photos/200/300",
          isPremium: false,
          duration: "10:45",
          author: 'Manifest',
        ),
        ManifestEntity(
          id: '2',
          title: 'Track',
          type: ManifestEntityType.track,
          image: "https://picsum.photos/200/300",
          isPremium: false,
          duration: "00:45",
          author: 'Rishi Shukla',
        ),
        ManifestEntity(
          id: '3',
          title: 'Playlist',
          type: ManifestEntityType.playlist,
          image: "https://picsum.photos/200/300",
          isPremium: false,
          duration: "01:25",
          author: 'Alok Singh',
        ),
        ManifestEntity(
          id: '4',
          title: 'Collection',
          type: ManifestEntityType.collection,
          image: "https://picsum.photos/200/300",
          isPremium: false,
          duration: "04:50",
          author: 'Rishi Shukla',
        ),
      ],
    );

    /// Todo 4. display premium features dialog
    /// ! Currently the video used in the bototmsheet is very high quality and crashes the app.
    /// ! Uncomment when the video with low quality or optmimum size or memory consumption is provided.
    // await AppDialogs.showPremiumFeatures(onExplorePressed: () {});
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.onClose();
  }

  void _onScroll() {
    scrollOffset.value = scrollController.offset;

    // Update gradient stops based on scroll
    final scrollProgress = (scrollOffset.value / 300)
        .clamp(0.0, 1.0); // Adjust 300 based on your needs
    gradientStartStop.value = 0.3 - (scrollProgress * 0.1);
    gradientMiddleStop.value = 0.5 - (scrollProgress * 0.2);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    precacheImage(
        const AssetImage('assets/images/HomePage_image.jpeg'), Get.context!);
  }

  Future fetchHomeData() async {
    try {
      LogUtil.i('Starting to fetch home data...');
      isProfileLoading.value = true;
      var response = await apiService.request(
        apiEndPoint:
            '${ApiService.home}?device_id=${LocalStorage.deviceID.toString()}&user_id=${profile.id}',
        isGet: true,
        withToken: false,
      );
      LogUtil.i('API Response Status: ${response.statusCode}');
      LogUtil.i('API Response Body: ${response.body}');
      var data = json.decode(response.body);
      LogUtil.v('Home Api Calling response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        LogUtil.v('Home Api Calling.....: ${data['message']}');
        homeDataModel.value = HomeDataModelByAlok.fromJson(data);
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        ToastUtil.error(data['message']);
      }
      isProfileLoading.value = false;
    } catch (e) {
      LogUtil.e('Error! while fetching home data: $e');
      isProfileLoading.value = false;
    }
  }

  Future<void> addToRecentlyPlayed({required int playListId}) async {
    try {
      isProfileLoading.value = true;
      Map<String, dynamic> body = {
        'user_id': profile.id,
        'play_list_id': playListId,
        //'device_id': deviceID.toString(),
      };
      var response = await apiService.request(
          apiEndPoint: ApiService.addToRecentPlayed,
          data: body,
          isPost: true,
          withToken: false);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        LogUtil.v('PlayList successfully added to recent');
        isProfileLoading.value = false;
      } else if (response.statusCode == 403 || response.statusCode == 422) {
        ToastUtil.error(data['message']);
        isProfileLoading.value = false;
      } else {
        LogUtil.e('Error while trying to add playlist in recent');
        ToastUtil.error(
            'Something went wrong from server side please try again');
        isProfileLoading.value = false;
      }
    } catch (e) {
      LogUtil.e('Error while add to Recent: $e');
      isProfileLoading.value = false;
    }
  }
}
