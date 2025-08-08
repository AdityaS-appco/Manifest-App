import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifest/core/constants/assets/icons_constants.dart';
import 'package:manifest/core/theme/app_text_styles.dart';
import 'package:manifest/core/utils.dart';
import 'package:manifest/features/playlist/by_you/widgets/common/svg_circle_button.dart';
import 'package:manifest/helper/constant.dart';

class PlayerOverlayScreenWithShareLikeAndReportOptions extends StatelessWidget {
  const PlayerOverlayScreenWithShareLikeAndReportOptions({
    super.key,
    this.affirmationText,
    required this.isAffirmationLiked,
    required this.onLikePressed,
    required this.onSharePressed,
    required this.onReportPressed,
  });

  final String? affirmationText;
  final RxBool isAffirmationLiked;
  final VoidCallback onLikePressed;
  final VoidCallback onSharePressed;
  final VoidCallback onReportPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              60.height,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  affirmationText ?? '',
                  style: helveticaRoundedPageTitleTextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    height: 1.43,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),
              24.height,
              _buildButtonsRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildButton(
          iconColor: isAffirmationLiked.value
              ? Colors.white
              : Colors.white.withOpacity(0.8),
          isAffirmationLiked.value
              ? IconAllConstants.heartRounded
              : IconAllConstants.heartRoundedOutlined,
          onPressed: onLikePressed,
        ),
        15.width,
        _buildButton(
          IconAllConstants.share01,
          onPressed: onSharePressed,
        ),
        15.width,
        _buildButton(
          IconAllConstants.tool02,
          onPressed: onReportPressed,
        ),
      ],
    );
  }

  Widget _buildButton(
    String icon, {
    required VoidCallback onPressed,
    Color? iconColor,
  }) {
    return SvgCircleButton(
      icon,
      onPressed: onPressed,
      iconSize: 28,
      iconColor: iconColor ?? Colors.white.withOpacity(0.8),
      padding: const EdgeInsets.all(13.5),
      buttonSize: 55,
      borderColor: Colors.white.withOpacity(0.1),
      enabledColor: Colors.white.withOpacity(0.1),
      isEnabled: true,
    );
  }
}
