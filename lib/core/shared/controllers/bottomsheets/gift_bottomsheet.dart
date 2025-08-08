import 'package:flutter_svg/flutter_svg.dart';
import 'package:manifest/core/shared/widgets/bottomsheets/custom_bottomsheet.dart';
import 'package:manifest/core/shared/widgets/custom_premium_banner.dart';
import 'package:manifest/core/shared/widgets/gradient_progress_bar.dart';
import 'package:manifest/core/shared/widgets/gradient_text_span.dart';
import 'package:manifest/core/shared/widgets/buttons/gradient_button.dart';
import 'package:manifest/core/theme/app_text_styles.dart';
import 'package:manifest/features/referral_program/controllers/gift_controller.dart';
import 'package:manifest/features/referral_program/models/reward_tier.dart';
import 'package:manifest/helper/import.dart';

class GiftBottomSheet extends GetView<GiftController> {
  const GiftBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      showDragHandle: true,
      hasBackButton: false,
      backgroundColor: const Color(0xFF252525).withOpacity(0.7),
      blurAmount: 64,
      maxHeight: Get.height * 0.95,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildGiftCard(),
          24.height,
          _buildShareMessage(),
          24.height,
          _buildProgressSection(),
          30.height,
          _buildRewardTiers(),
        ],
      ),
    );
  }

  Widget _buildGiftCard() {
    return Stack(
      children: [
        CustomPremiumBanner(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/logo/manifest_full_logo.svg',
                height: 32,
              ),
              84.height,
              Text(
                '14 Days',
                style: tanMemoriesPageTitleTextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              4.height,
              Text(
                'Gift Card',
                style: helveticaPageTitleTextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 11.87,
                  height: 1.18,
                  letterSpacing: -0.43,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),

        /// * it's hack - completely working
        Positioned(
          right: 1.5,
          bottom: 1.5,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Transform.translate(
                offset: const Offset(20, 20),
                child: Image.asset(
                  ImageConstants.gift,
                ),
              )),
        ),
      ],
    );
  }

  Widget _buildShareMessage() {
    return SizedBox(
      width: 335.w,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Share the love!',
              style: helveticaPageTitleTextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white.withOpacity(0.8),
                fontSize: 15,
                height: 1.47,
                letterSpacing: -0.43,
              ),
            ),
            TextSpan(
                text:
                    ' Invite friends to Manifest — they get 14 days free trial & you unlock FREE Manifest+ ✨',
                style: helveticaPageTitleTextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 15,
                  height: 1.47,
                  letterSpacing: -0.43,
                  fontWeight: FontWeight.w400,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSection() {
    return Obx(() => Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.05),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.05),
                        )),
                    child: SvgPicture.asset(
                      IconAllConstants.users02,
                      color: Colors.white.withOpacity(0.7),
                      height: 40,
                      width: 40,
                    ),
                  ),
                  12.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${controller.friendsJoined.value}',
                        style: helveticaPageTitleTextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.32,
                        ),
                      ),
                      4.height,
                      Text(
                        'Friends Joined',
                        style: helveticaPageTitleTextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.32,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              12.height,
              Row(
                children: [
                  SizedBox(
                    width: Get.width * 0.73,
                    child: const GradientProgressBar(progress: 0.4),
                  ),
                  const Spacer(),
                  Text(
                    '${controller.friendsJoined.value}/${controller.totalFriendsNeeded}',
                    style: helveticaPageTitleTextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
              12.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Only ${controller.totalFriendsNeeded - controller.friendsJoined.value} more friends to unlock ',
                          style: helveticaPageTitleTextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        GradientTextSpan(
                          '30 days of Manifest+ free',
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              15.height,
              _buildActionButtons(),
            ],
          ),
        ));
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        GradientButton.icon(
          text: 'Invite friends',
          svgIcon: IconAllConstants.users02Outlined,
          onPressed: controller.inviteFriends,
          padding: const EdgeInsets.all(8.5).r,
        ),
        12.height,
        GradientButton.icon(
          text: 'Share',
          svgIcon: IconAllConstants.share01,
          onPressed: controller.share,
          gradient: [AppColors.light, AppColors.light],
          padding: const EdgeInsets.all(8.5).r,
          foregroundColor: Colors.black,
        ),
      ],
    );
  }

  Widget _buildRewardTiers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (controller.rewardTiers
            .where((tier) => (tier.isClaimed))
            .isNotEmpty) ...[
          ...controller.rewardTiers
              .where((tier) => (tier.isClaimed))
              .map((tier) => _buildClaimedRewardTier(tier)),
          30.height,
        ],
        Text(
          'Unlock Manifest+ for FREE',
          style: helveticaRoundedPageTitleTextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        24.height,
        ...controller.rewardTiers
            .where((tier) => (!tier.isClaimed))
            .map((tier) => _buildClaimableRewardTier(tier)),
      ],
    );
  }

  Widget _buildClaimedRewardTier(RewardTier tier) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 42.h,
            width: 43.w,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            padding: const EdgeInsets.all(7),
            child: Image.asset(tier.icon, height: 28),
          ),
          16.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tier.friendsNeeded.toString(),
                  style: helveticaPageTitleTextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                2.height,
                Text(
                  "Friends Joined",
                  style: helveticaPageTitleTextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0.93,
                  ),
                ),
              ],
            ),
          ),
          16.width,
          Image.asset(
            ImageConstants.successTick,
            height: 16.h,
            width: 16.w,
          ),
        ],
      ),
    );
  }

  Widget _buildClaimableRewardTier(RewardTier tier) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                padding: const EdgeInsets.all(9),
                child: Image.asset(tier.icon, height: 60),
              ),
              16.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          GradientTextSpan(
                            '${tier.friendsNeeded} Friends',
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                    3.height,
                    Row(
                      children: [
                        Text(
                          tier.title,
                          style: helveticaPageTitleTextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          controller.friendsJoined.value > tier.friendsNeeded
                              ? "${tier.friendsNeeded} / ${tier.friendsNeeded}"
                              : "${controller.friendsJoined.value} / ${tier.friendsNeeded}",
                          style: helveticaPageTitleTextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    8.height,
                    GradientProgressBar(
                      progress:
                          ((controller.friendsJoined.value > tier.friendsNeeded)
                              ? 1
                              : (controller.friendsJoined.value /
                                  tier.friendsNeeded)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (controller.isRewardClaimable(tier)) ...[
            12.height,
            GradientButton.text(
              text: 'Claim Reward',
              gradient: AppColors.rainbowGradient,
              borderRadius: BorderRadius.circular(10).r,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              onPressed: () => controller.onRewardClaim(tier),
              padding: const EdgeInsets.symmetric(vertical: 10).r,
              borderWidth: 1.5,
              backgroundColorOpacity: 0.3,
              gradientDirection: GradientDirection.leftToRight,
            )
          ],
        ],
      ),
    );
  }
}
