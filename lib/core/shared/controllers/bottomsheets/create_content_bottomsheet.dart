import 'package:manifest/core/shared/widgets/artwork_image.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/helper/import.dart';
import 'package:manifest/view/widgets/text_field_widget.dart';

/// * A generic bottomsheet for creating content with artwork and name input
/// * Can be used for creating playlists, collections, etc.
class CreateContentBottomsheet extends StatelessWidget {
  final TextEditingController nameController;
  final String? imageUrl;
  final VoidCallback onCreatePressed;
  final VoidCallback? onImageEditPressed;
  final String buttonText;
  final String? titleText;
  final String hintText;

  const CreateContentBottomsheet({
    super.key,
    required this.nameController,
    required this.onCreatePressed,
    this.imageUrl,
    this.onImageEditPressed,
    this.buttonText = 'Create',
    this.titleText,
    this.hintText = 'Enter name',
  });

  /// * Factory constructor for creating a playlist
  factory CreateContentBottomsheet.playlist({
    required TextEditingController nameController,
    required VoidCallback onCreatePressed,
    String? imageUrl,
    VoidCallback? onImageEditPressed,
  }) {
    return CreateContentBottomsheet(
      nameController: nameController,
      onCreatePressed: onCreatePressed,
      imageUrl: imageUrl,
      onImageEditPressed: onImageEditPressed,
      hintText: 'Enter playlist name',
      buttonText: 'Create',
    );
  }

  /// * Factory constructor for creating a collection
  factory CreateContentBottomsheet.collection({
    required TextEditingController nameController,
    required VoidCallback onCreatePressed,
    String? imageUrl,
    VoidCallback? onImageEditPressed,
  }) {
    return CreateContentBottomsheet(
      nameController: nameController,
      onCreatePressed: onCreatePressed,
      imageUrl: imageUrl,
      onImageEditPressed: onImageEditPressed,
      hintText: 'Enter collection name',
      buttonText: 'Create',
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      hasBackButton: false,
      horizontalPadding: 0,
      topPadding: 0.r,
      bottomPadding: 30.r,
      contentPadding: EdgeInsets.fromLTRB(
        20.r,
        35.r,
        20.r,
        0.r,
      ),
      primaryButtonText: buttonText,
      onPrimaryButtonPressed: onCreatePressed,
      buttonsHorizontalPadding: 20.r,
      buttonsTopPadding: 30.r,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Artwork Image
          Center(
            child: ArtworkImage(
              imageUrl: imageUrl,
              isEditing: true,
              onEditTap: onImageEditPressed,
            ),
          ),

          33.height,

          // Name Input Field
          AppTextField(
            title: titleText,
            hintText: hintText,
            controller: nameController,
            backgroundColor: Colors.transparent,
            validator: FormValidatorUtil.name,
          ),
        ],
      ),
    );
  }
}
