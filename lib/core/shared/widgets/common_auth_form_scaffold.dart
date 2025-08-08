import 'package:manifest/core/shared/widgets/oval_blurred_widget.dart';
import 'package:manifest/core/shared/widgets/title_subtitle_header.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/transparent_svg_circle_button.dart';
import 'package:manifest/features/splash/star_splash_screen.dart';
import 'package:manifest/helper/import.dart';

class CommonAuthFormScaffold extends StatelessWidget {
  const CommonAuthFormScaffold({
    this.title,
    this.subtitle,
    this.subtitleWidget,
    required this.body,
    this.bottomsheet,
    this.formKey,
    this.isBackButtonVisible = true,
    this.hasOvalGradientCircleHeader = false,
    this.onBackPress,
    this.hasStarSplash = false,
    this.backButtonIconColor,
    this.contentPadding,
    this.starsZPosition = ZPosition.back,
    this.endSpacing,
  });

  final String? title;
  final String? subtitle;
  final Widget? subtitleWidget;

  final Widget body;
  final Widget? bottomsheet;
  final GlobalKey<FormState>? formKey;
  final VoidCallback? onBackPress;
  final bool isBackButtonVisible;
  final bool hasOvalGradientCircleHeader;
  final bool hasStarSplash;
  final Color? backButtonIconColor;
  final EdgeInsets? contentPadding;
  final ZPosition starsZPosition;
  final double? endSpacing;

  /// * Returns true if form should be enabled based on formKey presence
  bool get _isFormEnabled => formKey != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      bottomSheet: bottomsheet != null
          ? Container(
              decoration: BoxDecoration(
                color: AppColors.appBG,
                borderRadius: BorderRadius.zero,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: bottomsheet,
            )
          : null,
      body: hasStarSplash
          ? StarSplashScreen(
              starsZPosition: starsZPosition,
              child: _buildBody(),
            )
          : _buildBody(),
    );
  }

  Widget _buildBody() {
    return _isFormEnabled
        ? Form(
            key: formKey,
            child: _buildMainStack(),
          )
        : _buildMainStack();
  }

  Stack _buildMainStack() {
    return Stack(
      fit: StackFit.expand,
      children: [
        hasOvalGradientCircleHeader
            ? const OvalBlurredWidget()
            : const SizedBox.shrink(),
        _buildScrollView(),
        if (isBackButtonVisible) _buildBackButton(),
      ],
    );
  }

  SingleChildScrollView _buildScrollView() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding:
            (contentPadding ?? const EdgeInsets.symmetric(horizontal: 20)).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (title != null || subtitle != null) ...[
              TitleSubtitleHeader(
                title: title,
                subtitle: subtitle,
                subtitleWidget: subtitleWidget,
              ),
              33.height,
            ],
            body,
            endSpacing?.height ?? const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Positioned _buildBackButton() {
    return Positioned(
      top: 79.r,
      left: 7.5.w,
      child: TransparentSvgCircleButton(
        IconAllConstants.arrowLeft,
        onPressed: onBackPress ?? () => Get.back(),
        iconSize: 24,
        iconColor: Colors.white.withOpacity(0.8),
      ),
    );
  }
}
