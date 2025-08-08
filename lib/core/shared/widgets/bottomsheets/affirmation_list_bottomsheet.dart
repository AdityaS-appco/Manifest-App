import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:manifest/core/constants.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/custom_sliver_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/loading_wrapper.dart';
import 'package:manifest/core/theme.dart';
import 'package:manifest/core/utils.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/svg_circle_button.dart';
import 'package:manifest/models/explore_tab_model/featured_tab_model/featured_tab_model.dart';
import 'package:manifest/features/media_player/controllers/affirmation_list_bottomsheet_controller.dart';

class AffirmationListBottomsheet extends StatelessWidget {
  final PlaylistOrTrack track;
  final RxInt currentAffirmationIndex;
  final List<Color>? gradientColors;
  const AffirmationListBottomsheet(
    this.track,
    this.currentAffirmationIndex, {
    super.key,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
        AffirmationListBottomsheetController(track, currentAffirmationIndex));

    return SizedBox(
      height: Get.height * 0.9,
      child: LoadingWrapper(
        isInitialLoading: controller.isLoading,
        isLoading: controller.isTogglingAffirmationVisibility,
        child: CustomSliverBottomsheet(
          scrollController: controller.scrollController,
          maxHeight: Get.height * 0.8,
          minHeight: Get.height * 0.7,
          collapsedAppBarHeight: 125.h,
          expandedAppBarHeight: 520.h,
          gradientColors: gradientColors,
          slivers: [
            _buildAppBar(controller),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 16.h),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      delay: const Duration(milliseconds: 50),
                      child: SlideAnimation(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        child: FadeInAnimation(
                          duration: const Duration(milliseconds: 300),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: _buildAffirmationCard(controller, index),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: track.affirmations?.length ?? 0,
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 16.h),
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar(AffirmationListBottomsheetController controller) {
    return SliverAppBar(
      elevation: 0,
      pinned: true,
      collapsedHeight: 128.h,
      expandedHeight: 585.h,
      backgroundColor: Colors.white.withOpacity(0.05),
      floating: true,
      stretch: false,
      automaticallyImplyLeading: false,
      forceMaterialTransparency: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        stretchModes: const [
          StretchMode.blurBackground,
          StretchMode.fadeTitle,
          StretchMode.zoomBackground,
        ],
        titlePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        title: Obx(
          () => controller.isShrink.value
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        DragHandle(),
                      ],
                    ),
                    Text(
                      "${track.affirmations?.length ?? 0} affirmations $dotChar ${track.tracksTotalDuration ?? ""} $dotChar ${track.createdBy ?? "Unknown"}",
                      style: helveticaPageTitleTextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    13.height,
                    Text(
                      track.name?.capitalize ?? "Untitled",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
        background: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: _buildHeaderBackground(controller),
        ),
      ),
    );
  }

  Widget _buildHeaderBackground(
      AffirmationListBottomsheetController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const DragHandle(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 283.r,
              width: 283.r,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(track.image?.imageName ?? ""),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
            ),
          ],
        ),
        33.height,
        Text(
          "${track.affirmations?.length ?? 0} affirmations $dotChar ${track.tracksTotalDuration ?? ""}",
          style: helveticaPageTitleTextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
        10.height,
        Text(
          track.name?.capitalize ?? "Untitled",
          style: helveticaRoundedPageTitleTextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        13.height,
        // CreatorProfileTile(
        //   imageUrl: track.creator?.imageUrl ?? "https://via.placeholder.com/24",
        //   name: track.creator?.name ?? "Unknown",
        // ),
        16.height,
        Text(
          'Gabriel Muratori\'s affirmation Track gently eases anxiety with calming words and our little house',
          style: helveticaPageTitleTextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Colors.white.withOpacity(0.6),
            height: 1.77,
          ),
        ),
        13.height,
        if (track.tags != null && track.tags!.isNotEmpty)
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: track.tags!.split(',').map((tag) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 9, vertical: 8).r,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
                child: Text(
                  tag.trim(),
                  style: helveticaPageTitleTextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.32,
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildAffirmationCard(
      AffirmationListBottomsheetController controller, int index) {
    final affirmation = track.affirmations![index];

    return Obx(() {
      final bool isCurrentlyPlaying = currentAffirmationIndex.value == index;
      final bool isHidden = affirmation.isHidden.value;

      return Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12.r),
          border: isCurrentlyPlaying
              ? Border.all(
                  color: Colors.white.withOpacity(0.5),
                  width: 2,
                  strokeAlign: BorderSide.strokeAlignInside,
                )
              : Border.all(
                  color: Colors.white.withOpacity(0.05),
                  width: 1,
                ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                affirmation.description.toString(),
                style: helveticaPageTitleTextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  height: 1.33,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            14.width,
            isHidden
                ? _buildUnhideAffirmationButton(controller, index)
                : _buildAffirmationMoreButton(controller, index),
          ],
        ),
      );
    });
  }

  Widget _buildUnhideAffirmationButton(
      AffirmationListBottomsheetController controller, int index) {
    return Transform.scale(
      scale: 1.5,
      child: Transform.translate(
        offset: const Offset(6, 0),
        child: SvgCircleButton(
          IconAllConstants.invisible1_1_v1,
          onPressed: () => controller.hideUnhideAffirmation(index),
          iconSize: 12,
          padding: const EdgeInsets.all(7),
          enabledColor: Colors.transparent,
          disabledColor: Colors.transparent,
          iconColor: AppColors.light.withOpacity(0.3),
        ),
      ),
    );
  }

  Widget _buildAffirmationMoreButton(
      AffirmationListBottomsheetController controller, int index) {
    return Transform.scale(
      scale: 1.5,
      child: Transform.translate(
        offset: const Offset(6, 0),
        child: SvgCircleButton(
          IconAllConstants.menuVerticalDots1,
          onPressed: () => controller.showAffirmationOptions(index),
          iconSize: 12,
          padding: const EdgeInsets.all(7),
          enabledColor: Colors.transparent,
          disabledColor: Colors.transparent,
          iconColor: AppColors.light.withOpacity(0.4),
        ),
      ),
    );
  }
}
