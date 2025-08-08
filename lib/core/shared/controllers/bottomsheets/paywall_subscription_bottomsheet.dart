import 'package:flutter/gestures.dart';
import 'package:manifest/helper/import.dart';

/// ! A reusable bottom sheet widget for subscription-related actions
/// * Contains:
/// * 1. Primary action button with gradient
/// * 2. Billing info with cancel policy
/// * 3. Privacy and Agreement links
class PaywallSubscriptionBottomSheet extends StatelessWidget {
  const PaywallSubscriptionBottomSheet({
    super.key,
    required this.onSubscribe,
    required this.onPrivacyTap,
    required this.onAgreementTap,
    this.buttonText = 'Try Free & Subscribe',
    this.billingText = 'Cancel anytime, Billed Annually',
  });

  /// Callback when subscribe button is pressed
  final VoidCallback onSubscribe;

  /// Callback when privacy policy is tapped
  final VoidCallback onPrivacyTap;

  /// Callback when agreement is tapped
  final VoidCallback onAgreementTap;

  /// Custom text for the subscribe button
  final String buttonText;

  /// Custom text for billing information
  final String billingText;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.all(16.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Subscribe Button with Gradient
          _buildSubscribeButton(),

          SizedBox(height: 12.h),

          // Billing Info
          _buildBillingInfo(),

          SizedBox(height: 12.h),

          // Privacy and Agreement Links
          _buildLegalLinks(),
        ],
      ),
    );
  }

  /// * Gradient subscribe button
  Widget _buildSubscribeButton() {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.topLightToBottomDarkPurpleGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.r),
            ),
            elevation: 0, // Remove shadow
          ),
          onPressed: onSubscribe,
          child: Text(
            buttonText,
            style: Get.appTextTheme.titleMedium.copyWith(height: 1.25),
          ),
        ),
      ),
    );
  }

  /// * Billing information with icon
  Widget _buildBillingInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          ImageConstants.successTick,
          height: 16.r,
          width: 16.r,
        ),
        SizedBox(width: 8.w),
        Text(
          billingText,
          style: Get.appTextTheme.titleSmall.copyWith(
            fontWeight: FontWeight.w400,
            color: Colors.white.withAlpha(153),
            letterSpacing: 0,
          ),
        ),
      ],
    );
  }

  /// * Privacy policy and agreement links
  Widget _buildLegalLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegalLink('Privacy Policy', onPrivacyTap),
        32.width,
        _buildLegalLink('Agreement', onAgreementTap),
      ],
    );
  }

  /// * Individual legal link with tap recognition
  Widget _buildLegalLink(String text, VoidCallback onTap) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: Get.appTextTheme.contentTileSubtitleSmall.copyWith(
              color: const Color(0x66EBEBF5),
              fontWeight: FontWeight.w700,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
