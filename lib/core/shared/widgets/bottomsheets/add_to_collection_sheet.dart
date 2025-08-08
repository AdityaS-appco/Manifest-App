import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:manifest/core/shared/controllers/add_to_collection_sheet_controller.dart';
import 'package:manifest/core/shared/widgets/list_tiles/app_list_tile.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/app_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/create_content_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/loading_wrapper.dart';
import 'package:manifest/core/utils/media_util.dart';
import 'package:manifest/helper/import.dart';

class AddToCollectionSheet extends StatelessWidget {
  final String affirmationId;
  final VoidCallback? onButtonTap;
  final bool multiSelect;

  const AddToCollectionSheet({
    Key? key,
    required this.affirmationId,
    this.onButtonTap,
    this.multiSelect = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddToCollectionController());
    controller.isMultiSelect.value = multiSelect;

    final collectionNameController = TextEditingController(
        text: "#Collection ${controller.collections.length + 1}");

    return CustomBottomSheet(
      title: 'Add to Collection',
      titlePadding: EdgeInsets.symmetric(horizontal: 48.r),
      hasBackButton: true,
      primaryButtonText: 'Save',
      onPrimaryButtonPressed: () {
        if (onButtonTap != null) {
          onButtonTap!();
        } else {
          controller.addAffirmationToCollection(affirmationId);
        }
      },
      horizontalPadding: 20.r,
      contentPadding: EdgeInsets.zero,
      body: SizedBox(
        height: 500.h,
        child: LoadingWrapper(
          isInitialLoading: controller.isLoadingCollections,
          isLoading: controller.isAddingToCollection,
          onRefresh: controller.loadCollections,
          isRefreshing: controller.isRefreshingCollections,
          loadingBackgroundColor: Colors.transparent,
          child: Obx(
            () => ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: controller.collections.length + 1,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return AppListTile.createNew(
                    title: 'Create New Collection',
                    onTap: () {
                      final image = Rx<File?>(null);
                      AppBottomSheet.show(
                        Obx(
                          () {
                            return CreateContentBottomsheet.collection(
                              nameController: collectionNameController,
                              onCreatePressed: () =>
                                  controller.onCreateCollection(
                                name: collectionNameController.text,
                                image: image.value,
                              ),
                              imageUrl: image.value?.path,
                              onImageEditPressed: () async {
                                final pickedFile =
                                    await MediaUtil.pickAndCropImage(
                                  imageSource: ImageSource.gallery,
                                );
                                image.value = pickedFile;
                                image.refresh();
                              },
                            );
                          },
                        ),
                      );
                    },
                  );
                }

                final collection = controller.collections[index - 1];
                return Obx(
                  () => AppListTile.selectableWithTypeAndDuration(
                    artworkUrl: collection.image ?? '',
                    title: collection.name ?? '',
                    type: 'collection',
                    duration: collection.totalAffirmationsDurationString,
                    isSelected: controller.selectedCollectionIds
                        .contains(collection.id.toString()),
                    onTap: () => controller
                        .toggleCollectionSelection(collection.id.toString()),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
