import 'package:get/get.dart';
import 'package:manifest/features/explore/controllers/explore_category_list_controller.dart';
import 'package:manifest/features/explore/models/explore_category_model.dart';

mixin ExploreControllerMixin {
  final ExploreCategoryListController _exploreListController =
      Get.find<ExploreCategoryListController>();

  // Getter for the explore list controller
  ExploreCategoryListController get exploreListController => _exploreListController;

  // Getter for explore categories
  List<ExploreCategoryModel> get exploreCategories =>
      _exploreListController.categories;

  // Getter for loading state
  RxBool get isExploreDataLoading =>
      _exploreListController.isExploreDataLoading;
}
